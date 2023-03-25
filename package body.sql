--Creation of  PACKAGE
CREATE OR REPLACE PACKAGE contracts_pkg AS

  PROCEDURE generate_installments;

END contracts_pkg;
---Body of  PACKAGE

CREATE OR REPLACE PACKAGE BODY contracts_pkg AS

  PROCEDURE generate_installments IS
    v_added_months NUMBER(4);
    v_installment_date DATE;
    v_installment_count NUMBER;
  BEGIN
    FOR contracts_record IN (SELECT * FROM contracts) LOOP
      IF contracts_record.contract_payment_type = 'ANNUAL' THEN
        v_added_months := 12;
      ELSIF contracts_record.contract_payment_type = 'HALF_ANNUAL' THEN
        v_added_months := 6;
      ELSIF contracts_record.contract_payment_type = 'QUARTER' THEN
        v_added_months := 3;
      ELSIF contracts_record.contract_payment_type = 'MONTHLY' THEN
        v_added_months := 1;
      END IF;

      v_installment_date := contracts_record.contract_startdate;
      v_installment_count := 0;

      LOOP
        INSERT INTO installments_paid (INSTALLMENT_ID, CONTRACT_ID, INSTALLMENT_DATE, INSTALLMENT_AMOUNT, PAID)
        VALUES (installments_paid_seq.nextval, contracts_record.contract_id, v_installment_date, 0, 0);

        v_installment_date := ADD_MONTHS(v_installment_date, v_added_months);
        v_installment_count := v_installment_count + 1;

        IF v_installment_date = contracts_record.contract_enddate THEN
          EXIT;
        END IF;
      END LOOP;

      UPDATE installments_paid
      SET INSTALLMENT_AMOUNT = (contracts_record.contract_total_fees - NVL(contracts_record.contract_deposit_fees, 0)) / v_installment_count
      WHERE contract_id = contracts_record.contract_id;
    END LOOP;
  END generate_installments;

END contracts_pkg;

