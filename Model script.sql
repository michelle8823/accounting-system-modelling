

-- -----------------------------------------------------
-- Customer
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `idCustomer` INT NOT NULL,
  `CompanyName` VARCHAR(70) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(60) NOT NULL,
  `Phone` VARCHAR(20) NOT NULL,
  `Website` VARCHAR(80) NULL,
  PRIMARY KEY (`idCustomer`))
;


-- -----------------------------------------------------
-- Supplier
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Supplier` (
  `idSupplier` INT NOT NULL,
  `CompanyName` VARCHAR(70) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(60) NOT NULL,
  `Phone` VARCHAR(20) NOT NULL,
  `Website` VARCHAR(80) NULL,
  PRIMARY KEY (`idSupplier`))
;


-- -----------------------------------------------------
-- InvoicePayment
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`InvoicePayment` (
  `idInvoicePayment` INT NOT NULL,
  `Amount` DOUBLE NOT NULL,
  PRIMARY KEY (`idInvoicePayment`))
;


-- -----------------------------------------------------
-- Invoice
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Invoice` (
  `idInvoice` INT NOT NULL,
  `Item` VARCHAR(80) NOT NULL,
  `Description` VARCHAR(200) NULL,
  `Quantity` INT NOT NULL,
  `DiscountPercentage` DOUBLE NULL,
  `Account` VARCHAR(70) NOT NULL,
  `TaxRate` VARCHAR(70) NULL,
  `Amount` DOUBLE NOT NULL,
  `Issued` DATE NOT NULL,
  `Due` DATE NOT NULL,
  `idInvoicePayment` INT NOT NULL,
  `Customer_idCustomer` INT NOT NULL,
  PRIMARY KEY (`idInvoice`, `idInvoicePayment`, `Customer_idCustomer`),
  INDEX `fk_Invoice_InvoicePayment1_idx` (`idInvoicePayment` ASC),
  INDEX `fk_Invoice_Customer1_idx` (`Customer_idCustomer` ASC),
  CONSTRAINT `fk_Invoice_InvoicePayment1`
    FOREIGN KEY (`idInvoicePayment`)
    REFERENCES `mydb`.`InvoicePayment` (`idInvoicePayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Invoice_Customer1`
    FOREIGN KEY (`Customer_idCustomer`)
    REFERENCES `mydb`.`Customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table `mydb`.`ChartOfAccounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ChartOfAccounts` (
  `accountCode` INT NOT NULL,
  `Type` VARCHAR(45) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(45) NULL,
  `Tax` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`accountCode`))
;


-- -----------------------------------------------------
-- MoneyReceived
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MoneyReceived` (
  `idMoneyReceived` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Reference` VARCHAR(60) NULL,
  `Name` VARCHAR(80) NOT NULL,
  `Amount` DOUBLE NOT NULL,
  `idCustomer` INT NOT NULL,
  PRIMARY KEY (`idMoneyReceived`, `idCustomer`),
  INDEX `fk_MoneyReceived_Customer1_idx` (`idCustomer` ASC),
  CONSTRAINT `fk_MoneyReceived_Customer1`
    FOREIGN KEY (`idCustomer`)
    REFERENCES `mydb`.`Customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- MoneySpent
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MoneySpent` (
  `idMoneyPaid` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Reference` VARCHAR(60) NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Amount` DOUBLE NOT NULL,
  `idSupplier` INT NOT NULL,
  PRIMARY KEY (`idMoneyPaid`, `idSupplier`),
  INDEX `fk_MoneyPaid_Supplier1_idx` (`idSupplier` ASC),
  CONSTRAINT `fk_MoneyPaid_Supplier1`
    FOREIGN KEY (`idSupplier`)
    REFERENCES `mydb`.`Supplier` (`idSupplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- BillPayment
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`BillPayment` (
  `idBillPayment` INT NOT NULL,
  `Amount` DOUBLE NOT NULL,
  PRIMARY KEY (`idBillPayment`))
;


-- -----------------------------------------------------
-- Bill
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `idBill` INT NOT NULL,
  `Item` VARCHAR(80) NOT NULL,
  `Description` VARCHAR(200) NULL,
  `Quantity` INT NOT NULL,
  `unitPrice` DOUBLE NOT NULL,
  `TaxRate` VARCHAR(70) NULL,
  `Amount` DOUBLE NOT NULL,
  `Due` DATE NOT NULL,
  `idBillPayment` INT NOT NULL,
  `Supplier_idSupplier` INT NOT NULL,
  PRIMARY KEY (`idBill`, `idBillPayment`, `Supplier_idSupplier`),
  INDEX `fk_Bill_BillPayment1_idx` (`idBillPayment` ASC),
  INDEX `fk_Bill_Supplier1_idx` (`Supplier_idSupplier` ASC),
  CONSTRAINT `fk_Bill_BillPayment1`
    FOREIGN KEY (`idBillPayment`)
    REFERENCES `mydb`.`BillPayment` (`idBillPayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bill_Supplier1`
    FOREIGN KEY (`Supplier_idSupplier`)
    REFERENCES `mydb`.`Supplier` (`idSupplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Invoice_has_ChartOfAccounts
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Invoice_has_ChartOfAccounts` (
  `Invoice_idInvoice` INT NOT NULL,
  `Invoice_idInvoicePayment` INT NOT NULL,
  `Invoice_Customer_idCustomer` INT NOT NULL,
  `ChartOfAccounts_accountCode` INT NOT NULL,
  PRIMARY KEY (`Invoice_idInvoice`, `Invoice_idInvoicePayment`, `Invoice_Customer_idCustomer`, `ChartOfAccounts_accountCode`),
  INDEX `fk_Invoice_has_ChartOfAccounts_ChartOfAccounts1_idx` (`ChartOfAccounts_accountCode` ASC),
  INDEX `fk_Invoice_has_ChartOfAccounts_Invoice1_idx` (`Invoice_idInvoice` ASC, `Invoice_idInvoicePayment` ASC, `Invoice_Customer_idCustomer` ASC),
  CONSTRAINT `fk_Invoice_has_ChartOfAccounts_Invoice1`
    FOREIGN KEY (`Invoice_idInvoice` , `Invoice_idInvoicePayment` , `Invoice_Customer_idCustomer`)
    REFERENCES `mydb`.`Invoice` (`idInvoice` , `idInvoicePayment` , `Customer_idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Invoice_has_ChartOfAccounts_ChartOfAccounts1`
    FOREIGN KEY (`ChartOfAccounts_accountCode`)
    REFERENCES `mydb`.`ChartOfAccounts` (`accountCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Bill_has_ChartOfAccounts
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill_has_ChartOfAccounts` (
  `Bill_idBill` INT NOT NULL,
  `Bill_idBillPayment` INT NOT NULL,
  `Bill_Supplier_idSupplier` INT NOT NULL,
  `ChartOfAccounts_accountCode` INT NOT NULL,
  PRIMARY KEY (`Bill_idBill`, `Bill_idBillPayment`, `Bill_Supplier_idSupplier`, `ChartOfAccounts_accountCode`),
  INDEX `fk_Bill_has_ChartOfAccounts_ChartOfAccounts1_idx` (`ChartOfAccounts_accountCode` ASC),
  INDEX `fk_Bill_has_ChartOfAccounts_Bill1_idx` (`Bill_idBill` ASC, `Bill_idBillPayment` ASC, `Bill_Supplier_idSupplier` ASC),
  CONSTRAINT `fk_Bill_has_ChartOfAccounts_Bill1`
    FOREIGN KEY (`Bill_idBill` , `Bill_idBillPayment` , `Bill_Supplier_idSupplier`)
    REFERENCES `mydb`.`Bill` (`idBill` , `idBillPayment` , `Supplier_idSupplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bill_has_ChartOfAccounts_ChartOfAccounts1`
    FOREIGN KEY (`ChartOfAccounts_accountCode`)
    REFERENCES `mydb`.`ChartOfAccounts` (`accountCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;
