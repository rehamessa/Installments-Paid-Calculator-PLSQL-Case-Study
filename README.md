# Installments-Paid-Calculator-PLSQL-Case-Study
This program is a PL/SQL script that calculates the number and amount of installments paid for contracts based on their payment type. It uses Oracle Database and the PL/SQL programming language to iterate over a cursor containing contract records, insert installment records into a table, and update the installment amount for each contract based on the number of installments calculated.
*- the installment amount is caculated by dividing the total fees by the number of installments based on the payment frequency.
- works with four payment frequencies: annual, half-annual, quarterly, and monthly. For annual payment frequency, the program generates one payment per year; for half-annual payment frequency, the program generates two payments per year, and so on.
## Technology Used
* Oracle Database 
* PL/SQL Programming Language
* Procedure
* Packages
