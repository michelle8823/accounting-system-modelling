# Accounting System Modelling

## About
A simplified accounting system database system which includes the sales and purchase cycle referencing Xero.
Entities included:
* Customer
* Supplier
* Chart of Accounts
* Invoice
* Bill
* InvoicePayment
* BillPayment
* MoneyReceived
* MoneySpent 

## Purchase Cycle
Includes supplier, bill, bill payments and money spent
- One supplier can have many bills
- One bill can be linked to many bill payments
- Money spent on paying suppliers

## Sales Cycle
Includes customer, invoice, invoice payments and money received
- One supplier can have many invoices
- One invoice can be linked to many invoice payments
- Money received from customers purchasing our goods/services
