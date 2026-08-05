<!-- Source: VSS - Data Mapping.xlsx — reference data provided by DAS Technology.
     Converted from XLSX; original lives in the shared Drive folder. -->

# VSS — Data Mapping

> **Reference data provided by DAS.** Converted from the original spreadsheet. This is a DAS source document, not a Conflict deliverable.
>
> Original: [vss-data-mapping.xlsx](/artifacts/phase-0/source-docs/vss-data-mapping.xlsx)

---

## VSS Fields

| Vehicle & Owner Information |  |  |  |  |  |
| --- | --- | --- | --- | --- | --- |
| Field Name | Authenticom Supported | CDK Supported | Database Name | Table | Column |
| CustomerFirstName | Yes | Yes | EDW_staging | source_dms_sales/source_dms_service | CustomerFirstName |
| CustomerLastName | Yes | Yes | EDW_staging | source_dms_sales/source_dms_service | CustomerLastName |
| CustomerEmail | Yes | Yes | EDW_staging | source_dms_sales/source_dms_service | CustomerEmail |
| CustomerCellPhone | Yes | Yes | EDW_staging | source_dms_sales/source_dms_service | CustomerCellPhone |
| VehicleYear | Yes | Yes | EDW_staging | source_dms_sales/source_dms_service | VehicleYear |
| VehicleMake | Yes | Yes | EDW_staging | source_dms_sales/source_dms_service | VehicleMake |
| VehicleModel | Yes | Yes | EDW_staging | source_dms_sales/source_dms_service | VehicleModel |
| TrimLevel | Yes | Yes | EDW_staging | source_dms_sales/source_dms_service | TrimLevel |
| VehicleVIN | Yes | Yes | EDW_staging | source_dms_sales/source_dms_service | VehicleVIN |
| PurchaseDate | Yes | Yes | EDW_staging | source_dms_sales/source_dms_service | ClosedDate // DealBookDate/ContractDate |
| VehicleMileage | Yes | Yes | EDW_staging | source_dms_sales/source_dms_service | VehicleMileage |
| PurchasePrice | Yes | Yes | EDW_staging | source_dms_sales/source_dms_service | FrontGross+BackGross // ROAmount |
| VehicleCondition | No | No | N/A | N/A | N/A |
| Service & Parts |  |  |  |  |  |
| Field Name | Authenticom Supported | CDK Supported | Database Name | Table | Column |
| OemMaintenanceSchedule with Dates or Mileage | No | No | N/A | N/A | N/A |
| CompletedServices with Dates or Mileage | No | No | N/A | N/A | N/A |
| DeclinedServices | No | No | N/A | N/A | N/A |
| OpenRecalls By VIN | No | No | acceleratordb | leads_recall_data | See RecallMasters Sheet |
| CompletedRecalls By VIN | No | No | N/A | N/A | N/A |
| Service History |  |  |  |  |  |
| Field Name | Authenticom Supported | CDK Supported | Database Name | Table | Column |
| CompletedServicesWithDatesOrMileageAndPictures | No | No |  |  |  |
| ServiceCoupon(s) | No | No |  |  |  |
| ServicePlanOffering | COX? | No |  |  |  |
| Protect Your Vehicle! |  |  |  |  |  |
| Field Name | Provider(s) |  |  |  |  |
| ServiceOrWarranyPlanOfferings | N/A - COX? |  |  |  |  |
| Additional Offers |  |  |  |  |  |
| Field Name | Provider(s) |  |  |  |  |
| OptionalAddons | N/A |  |  |  |  |
| Equity & Trade-In Opportunities |  |  |  |  |  |
| Field Name | Provider(s) |  | Database Name | Table | Column |
| EquityAmount | BlackBook |  | Edw_staging | stage_Vehicle_Valuation | See BlackBook Sheet |
| Market Value | BlackBook |  | Edw_staging | stage_Vehicle_Valuation | See BlackBook Sheet |
| Vehicle Upgrade Options |  |  |  |  |  |
| Field Name | Provider(s) |  |  |  |  |
| VehicleUpgradeOptions | ResponseLogix? |  |  |  |  |
| Shop for a New Vehicle Insurance Quote |  |  |  |  |  |
| Field Name | Provider(s) |  |  |  |  |
| InsuranceProviderQuoteList | N/A |  |  |  |  |

## BlackBook

| Column | Data Type | Example Data |  | Sample Data Ticket |
| --- | --- | --- | --- | --- |
| ClientID | text | 188 |  | https://digitalairstrike.atlassian.net/browse/CDXP-7245 |
| VIN | text | 1G1FA1RS2N0124935 |  |  |
| Make | text | Chevrolet |  |  |
| Model | text | Camaro |  |  |
| Model_year | text | 2022 |  |  |
| Amount_paid | text | 21982.1 |  |  |
| Amount_financed | text | 38340.8 |  |  |
| Months_term | text | 75 |  |  |
| Months_paid | text | 43 |  |  |
| Months_remaining | text | 32 |  |  |
| Monthly_payment | text | 511.211 |  |  |
| Estimated_mileage | text | 47169 |  |  |
| Tradein_clean | text | 22055 |  |  |
| Tradein_average | text | 20740 |  |  |
| Tradein_rough | text | 17895 |  |  |
| Tradein_xclean | text | 22675 |  |  |
| Equity | text | 1536.24 |  |  |
| Last_processed | date and time | 2026-03-02 05:36:50.360000 |  |  |
| State | text | KY |  |  |
| EDW_DMS_CustomerID | number | 30925875 |  |  |
| RemainingAmount | number | 16358 |  |  |

## RecallMasters

| Column | Data Type | Example Data |
| --- | --- | --- |
| id | number | 116224 |
| lead_id | number | 12791584 |
| lead_vin | text | 1G1FF1R74L0148891 |
| lead_client_id | number | 216445 |
| recall_id | number | 263636 |
| recall_name | text | Transmission Damage May Cause Wheel Lock Up |
| recall_description | text | Transmission damage may cause wheel lock up |
| recall_risk | text | Wheel lock up while driving increases the risk of a crash. |
| recall_risk_type | text | collision |
| recall_remedy | text | Dealers will install transmission control module monitoring software, free of charge. |
| recall_risk_rank | number | 4 |
| date_added | date and time | 2026-02-26 19:51:06 |
| recall_nhtsa_id | text | 25V148000 |
| recall_oem_id | text | GM N242480630 |
| recall_dont_drive | true/false | False |
| recall_effective_date | date and time | 2025-03-06 00:00:00 |
| is_remedy_available | true/false | True |
| are_parts_available | true/false | True |
| recall_profit_rank | number | 4 |
| recall_overall_rank | number | 4 |
| recall_labor_difficulty | number | 3 |
| lead_model_year | number | 2020 |
| lead_model_name | text | Camaro A |
| lead_model_make | text | CHEVROLET |
| recall_count | number | 1 |

## Source DMS Sales

| Column | Data Type | Example Data |
| --- | --- | --- |
| EDW_DMS_Sales_ID | number | 132358763 |
| FileType | text | Sales |
| ACDealerID | text | DVD61621 |
| ClientDealerID | text | 216454 |
| DMSType | text | R & R |
| DealNumber | text | 107086 |
| CustomerNumber | text | 42188 |
| CustomerName | text | SAMMIE PRIGMORE PITRUCHA |
| CustomerFirstName | text | SAMMIE |
| CustomerLastName | text | PITRUCHA |
| CustomerAddress | text | 1306 SHWY 146 |
| CustomerCity | text | BAYTOWN |
| CustomerState | text | TX |
| CustomerZip | text | 77520 |
| CustomerCounty | text | HARRIS |
| CustomerHomePhone | text | (281) 794-4157 |
| CustomerWorkPhone | text |  |
| CustomerCellPhone | text | (281) 794-4157 |
| CustomerPagerPhone | text |  |
| CustomerEmail | text | SAMMIEPIT007@YAHOO.COM |
| CustomerBirthDate | text | 1953-10-24 00:00:00 |
| MailBlock | text (Y/N) |  |
| CoBuyerName | text | STEVE CHARLES PITRUCHA |
| CoBuyerFirstName | text | STEVE |
| CoBuyerLastName | text | PITRUCHA |
| CoBuyerAddress | text | 1306 SHWY 146 |
| CoBuyerCity | text | BAYTOWN |
| CoBuyerState | text | TX |
| CoBuyerZip | text | 77520 |
| CoBuyerCounty | text |  |
| CoBuyerHomePhone | text | (281) 794-4157 |
| CoBuyerWorkPhone | text |  |
| CoBuyerBirthDate | text | 1951-07-17 00:00:00 |
| Salesman_1_Number | text | 1178 |
| Salesman_1_Name | text | ANTHONY NGUYEN |
| Salesman_2_Number | text |  |
| Salesman_2_Name | text |  |
| ClosingManagerName | text | NOEL DANIEL |
| ClosingManagerNumber | text | 1050 |
| F_AND_I_ManagerNumber | text | 1006 |
| F_AND_I_ManagerName | text | HASAN MAJIED |
| SalesManagerNumber | text |  |
| SalesManagerName | text | HASAN MAJIED |
| EntryDate | text | 2026-02-20 00:00:00 |
| DealBookDate | text | 2026-02-20 00:00:00 |
| VehicleYear | text | 2023 |
| VehicleMake | text | SUBARU |
| VehicleModel | text | ASCENT |
| VehicleStockNumber | text | C92151A |
| VehicleVIN | text | 4S4WMAWD8P3417272 |
| VehicleExteriorColor | text | CRYSTAL WHITE PEARL |
| VehicleInteriorColor | text |  |
| VehicleMileage | text | 48279 |
| VehicleType | text | USED |
| InServiceDate | text | 2026-02-20 00:00:00 |
| HoldBackAmount | text | 0 |
| DealType | text | D |
| SaleType | text | R |
| BankCode | text | 18525 |
| BankName | text | JPMORGAN CHASE BANK NA (SUBARU) |
| SalesmanCommission | text | 125 |
| GrossProfitSale | text | -1229.02 |
| FinanceReserve | text | 1929 |
| CreditLifePremium | text | 0 |
| CreditLifeCommision | text | 0 |
| TotalInsuranceReserve | text | 1729 |
| BalloonAmount | text | 0 |
| CashPrice | text | 30880 |
| AmountFinanced | text | 45842.8 |
| TotalOfPayments | text | 0 |
| MSRP | text | 32550 |
| DownPayment | text | 1000 |
| SecurityDesposit | text |  |
| Rebate | text | 0 |
| Term | text | 72 |
| RetailPayment | text | 744.47 |
| PaymentType | text |  |
| RetailFirstPayDate | text | 2026-03-22 00:00:00 |
| LeaseFirstPayDate | text |  |
| DayToFirstPayment | text | 30 |
| LeaseAnnualMiles | text |  |
| MileageRate | text |  |
| APRRate | text | 5.29 |
| ResidualAmount | text |  |
| LicenseFee | text | 0 |
| RegistrationFee | text | 0 |
| TotalTax | text | 809.33 |
| ExtendedWarrantyName | text | GOLD PLUS UPGRADE |
| ExtendedWarrantyTerm | text | 84 |
| ExtendedWarrantyLimitMiles | text | 100000 |
| ExtendedWarrantyDollar | text | 1480 |
| ExtendedWarrantyProfit | text | 3195 |
| FrontGross | text | -1229.02 |
| BackGross | text | 1929 |
| TradeIn_1_VIN | text | JF2GUADC0RH371558 |
| TradeIn_2_VIN | text |  |
| TradeIn_1_Make | text | SUBARU |
| TradeIn_2_Make | text |  |
| TradeIn_1_Model | text | CROSSTREK |
| TradeIn_2_Model | text |  |
| TradeIn_1_ExteriorColor | text | BLUE |
| TradeIn_2_ExteriorColor | text |  |
| TradeIn_1_Year | text | 2024 |
| TradeIn_2_Year | text |  |
| TradeIn_1_Mileage | text | 28043 |
| TradeIn_2_Mileage | text |  |
| TradeIn_1_Gross | text | 21000 |
| TradeIn_2_Gross | text | 0 |
| TradeIn_1_Payoff | text | 30098.72 |
| TradeIn_2_Payoff | text | 0 |
| TradeIn_1_ACV | text | 20000 |
| TradeIn_2_ACV | text | 0 |
| Fee_1_Name | text | PROPACK |
| Fee_1_Fee | text | 1985 |
| Fee_1_Commission | text | 0 |
| Fee_2_Name | text |  |
| Fee_2_Fee | text | 0 |
| Fee_2_Commission | text | 0 |
| Fee_3_Name | text |  |
| Fee_3_Fee | text | 0 |
| Fee_3_Commission | text | 0 |
| Fee_4_Name | text |  |
| Fee_4_Fee | text | 0 |
| Fee_4_Commission | text | 0 |
| Fee_5_Name | text |  |
| Fee_5_Fee | text | 0 |
| Fee_5_Commission | text | 0 |
| Fee_6_Name | text |  |
| Fee_6_Fee | text | 0 |
| Fee_6_Commission | text | 0 |
| Fee_7_Name | text |  |
| Fee_7_Fee | text | 0 |
| Fee_7_Commission | text | 0 |
| Fee_8_Name | text |  |
| Fee_8_Fee | text | 0 |
| Fee_8_Commission | text | 0 |
| Fee_9_Name | text |  |
| Fee_9_Fee | text | 0 |
| Fee_9_Commission | text | 0 |
| Fee_10_Name | text |  |
| Fee_10_Fee | text | 0 |
| Fee_10_Commission | text | 0 |
| ContractDate | text | 2026-02-20 00:00:00 |
| InsuranceName | text | STATE FARM |
| InsuranceAgentName | text |  |
| InsuranceAddress | text |  |
| InsuranceCity | text |  |
| InsuranceState | text |  |
| InsuranceZip | text |  |
| InsurancePhone | text | (800) 782-8332 |
| InsurancePolicyNumber | text | 0747918SFP53 |
| InsuranceEffectiveDate | text |  |
| InsuranceExpirationDate | text | 2026-06-14 00:00:00 |
| InsuranceCompensationDeduction | text |  |
| TradeIn_1_InteriorColor | text |  |
| TradeIn_2_InteriorColor | text |  |
| PhoneBlock | text (Y/N) |  |
| LicensePlateNumber | text |  |
| Cost | text | 29504 |
| InvoiceAmount | text |  |
| FinanceCharge | text | 7759.04 |
| TotalPickupPayment | text |  |
| TotalAccessories | text |  |
| TotalDriveOffAmount | text | 0 |
| EmailBlock | text (Y/N) |  |
| ModelDescriptionOfCarSold | text | TOURING 7-PASSENGER |
| VehicleClassification | text | TRUCK |
| ModelNumberOfCarSold | text | TRUCK |
| GAPPremium | text | 500 |
| LastInstallmentDate | text | 2032-02-22 00:00:00 |
| CashDeposit | text | 0 |
| AHPremium | text | 0 |
| LeaseRate | text |  |
| DealerSelect | text | 2026-04-01 00:00:00 |
| LeasePayment | text | 0 |
| LeaseNetCapCost | text |  |
| LeaseTotalCapReduction | text |  |
| DealStatus | text | F |
| CustomerSuffix | text |  |
| CustomerSalutation | text |  |
| CustomerAddress2 | text |  |
| CustomerMiddleName | text | PRIGMORE |
| GlobalOptOut | text (Y/N) | N |
| LeaseTerm | text | 0 |
| ExtendedWarrantyFlag | text |  |
| Salesman_3_Number | text |  |
| Salesman_3_Name | text |  |
| Salesman_4_Number | text |  |
| Salesman_4_Name | text |  |
| Salesman_5_Number | text |  |
| Salesman_5_Name | text |  |
| Salesman_6_Number | text |  |
| Salesman_6_Name | text |  |
| APRRate2 | text |  |
| APRRate3 | text |  |
| APRRate4 | text |  |
| Term2 | text |  |
| SecurityDeposit2 | text |  |
| DownPayment2 | text |  |
| TotalOfPayments2 | text |  |
| BasePayment | text |  |
| JournalSaleAmount | text | 30880 |
| IndividualBusinessFlag | text | I |
| InventoryDate | text | 2026-01-19 00:00:00 |
| StatusDate | text | 2026-02-24 00:00:00 |
| ListPrice | text | 0 |
| NetTradeAmount | text | -9098.72 |
| TrimLevel | text | TOURING |
| SubTrimLevel | text |  |
| BodyDescription | text | TOURING 7-PASSENGER |
| BodyDoorCount | text |  |
| TransmissionDesc | text | A |
| EngineDesc | text |  |
| TypeCode | text |  |
| SLCT2 | text |  |
| DealDateOffset | text |  |
| AccountingDate | text | 2026-02-24 00:00:00 |
| CoBuyerCustNum | text |  |
| CoBuyerCell | text | (281) 428-1858 |
| CoBuyerEmail | text | STEVEPIT007@YAHOO.COM |
| CoBuyerSalutation | text |  |
| CoBuyerPhoneBlock | text |  |
| CoBuyerMailBlock | text |  |
| CoBuyerEmailBlock | text |  |
| RealBookDate | text |  |
| CoBuyerMiddleName | text | CHARLES |
| CoBuyerCountry | text |  |
| CoBuyerAddress2 | text |  |
| CoBuyerOptOut | text | N |
| CoBuyerOccupation | text |  |
| CoBuyerEmployer | text |  |
| Country | text |  |
| Occupation | text |  |
| Employer | text |  |
| Salesman2Commission | text | 0 |
| BankAddress | text | 4070 WILLOW LAKE BLVD STE 2021 MEMPHIS, TN 38118 |
| BankCity | text | MEMPHIS |
| BankState | text | TN |
| BankZip | text | 38118 |
| LeaseEstimatedMiles | text |  |
| AFTReserve | text |  |
| CreditLifePrem | text | 0 |
| CreditLifeRes | text | 0 |
| AHRes | text | 0 |
| Language | text |  |
| BuyRate | text |  |
| DMVAmount | text |  |
| Weight | text |  |
| StateDMVTotFee | text |  |
| ROSNumber | text |  |
| Incentives | text | -35 |
| FileName | text | E:\Data\DMS\3_Staging_Sales\216454-20260302-SALES.csv |
| IsProcessed | true/false | True |
| InsertDate | date and time | 2026-03-02 08:35:47.850000 |

## Source DMS Service

| Column | Data Type | Example Data |
| --- | --- | --- |
| EDW_DMS_Service_ID | number | 177015640 |
| FileType | text | Service |
| ACDealerID | text | DVD50122 |
| ClientDealerID | text | 216452 |
| DMSType | text | DealerTrack |
| RONumber | text | 6286802 |
| OpenDate | text | 2026-02-18 00:00:00 |
| CustomerNumber | text | 280108 |
| CustomerName | text | JOHN SOTO |
| CustomerFirstName | text | JOHN |
| CustomerLastName | text | SOTO |
| CustomerAddress | text | 4105 OAK WOOD DRIVE |
| CustomerCity | text | FAIRFIELD |
| CustomerState | text | CA |
| CustomerZip | text | 94534 |
| CustomerHomePhone | text | (925) 457-3379 |
| CustomerWorkPhone | text |  |
| CustomerCellPhone | text |  |
| CustomerEmail | text | N@A.COM |
| CustomerBirthdate | text |  |
| VehicleMileage | text | 2695 |
| VehicleYear | text | 2026 |
| VehicleMake | text | GMC |
| VehicleModel | text | SIERRA 1500 |
| VehicleVIN | text | 1GTUUGE80TZ112049 |
| ServiceAdvisorNumber | text | 952 |
| ServiceAdvisorName | text | ANDREW SNIDER |
| TechnicianName | text |  |
| TechnicianNumber | text | 748\|\| |
| DeliveryDate | text |  |
| OperationCode | text | DIAG1\|TIRES\|MPI |
| OperationDescription | text | MINOR DIAGNOSIS\|YOUR TIRES HAVE BEEN SET TO FACTORY PRESSURES ACCORDING TO THE DECAL ON THE DRIVERS FRONT DOOR.\|PERFORM COMPLIMENTARY MULTI-POINT INSPECTION WITH VIDEO INSPECTION |
| ROAmount | text | 14907.32 |
| WarrantyName | text |  |
| WarrantyExpirationDate | text |  |
| WarrantyExpirationMiles | text |  |
| SalesmanNumber | text |  |
| SalesmanName | text |  |
| ClosedDate | text | 2026-02-28 00:00:00 |
| LaborTypes | text | W\|C\|C |
| WarrantyLaborAmount | text | 6541.62 |
| WarrantyPartJobSale | text | 8363.95 |
| WarrantyMiscAmount | text |  |
| WarrantyRepairOrderTotal | text | 14907.32 |
| InternalLaborSale | text | 0 |
| InternalPartsSale | text | 0 |
| InternalMiscAmount | text |  |
| InternalRepairOrderTotal | text | 0 |
| CustomerPayLaborAmount | text | 0 |
| CustomerPayPartsSale | text | 0 |
| CustomerPayMiscSale | text |  |
| CustomerPayRepairOrderTotal | text | 0 |
| LaborCostDollar | text | 1028.1 |
| PartsCostDollar | text | 4362.61 |
| MiscCostDollar | text |  |
| MiscDollar | text |  |
| LaborDollar | text | 6541.62\|\| |
| PartsDollar | text | 8363.95\|\| |
| VehicleColor | text |  |
| CustomerPayPartsCost | text | 0 |
| CustomerPayLaborCost | text | 0 |
| CustomerPayGOGCost | text |  |
| CustomerPaySubletCost | text |  |
| CustomerPayMiscCost | text |  |
| WarrantyPartsCost | text | 4362.61 |
| WarrantyLaborCost | text | 1028.1 |
| WarrantyGOGCost | text |  |
| WarrantySubletCost | text |  |
| WarrantyMiscCost | text |  |
| InternalPartsCost | text |  |
| InternalLaborCost | text |  |
| InternalGOGCost | text |  |
| InternalSubletCost | text |  |
| InternalMiscCost | text |  |
| TotalTax | text |  |
| TotalLaborHours | text | 26.20\|\| |
| TotalBillHours | text |  |
| ServiceComment | text |  |
| LaborComplaint | text |  |
| LaborBillingRate | text |  |
| LaborTechnicianRate | text |  |
| AppointmentFlag | text |  |
| MailBlock | text (Y/N) | N |
| EmailBlock | text (Y/N) | N |
| PhoneBlock | text (Y/N) | N |
| ROInvoiceDate | text |  |
| ROCustomerPayPostDate | text |  |
| ROStatus | text |  |
| MechanicNumber | text | 748\|\| |
| ROMileage | text | 2695 |
| DeliveryMileage | text |  |
| StockNumber | text |  |
| RecommendedService | text |  |
| Recommendations | text |  |
| CustomerSuffix | text |  |
| CustomerSalutation | text |  |
| CustomerAddress2 | text |  |
| CustomerMiddleName | text |  |
| GlobalOptOut | text |  |
| PromiseDate | text |  |
| PromiseTime | text |  |
| ROLogon | text |  |
| LaborTypes2 | text |  |
| LanguagePreference | text |  |
| MiscCode | text |  |
| MiscCodeAmount | text |  |
| PartNumber | text | 40009641^40009641-C^40009641-C^55490621^55496995^11604344^24001296^55497445^55503171^55494570^12670252^55512949^55507833^55503127^13579648^13579646^13579649^40009254^55494714^84763642^55496956^55496955^55496593^55497083^11588835\|\| |
| PartDescription | text | N-ENGINE (00000^N-ENGINE (000^N-ENGINE (000^SL-N-GASKET (03680-CT^SL-N-GASKET (03680-CT^SL-N-BOLT (03690-BOPCK^N-PIPE (03358-CT)^N-GASKET (03374-BCKT)^N-CLAMP (03708-CKT)^N-GASKET (03690-CKT)^SL-N-SEAL (01516-BCKT)^N-GASKET (03342-CT)^SL-N-GASKET (03270-^SL-N-GASKET KIT (032^SL-N-SEAL (09222-BOP^SL-N-SEAL (09222-BO^SL-N-SEAL (09190-BOP^SL-N-CLAMP (03672-CT)^N-GASKET (03611-CT)^N-GASKET (03611-CT)^N-GASKET (03374-CT)^SL-N-GASKET (01252-CT)^SL-N-SEAL (03680-CKT)^SL-N-GASKET (03680-CT)^SL-N-NUT (08915-BOPCKT)\|\| |
| PartQuantity | text | 1^1^1^1^1^2^1^1^1^1^1^1^1^1^2^2^2^1^2^1^1^2^1^1^3\|\| |
| MiscCodeDescription | text |  |
| MakePrefix | text |  |
| Department | text |  |
| ROTotalCost | text | 5390.71 |
| PipedComplaint | text |  |
| PipedComment | text |  |
| MileageOut | text | 2695 |
| IndividualBusinessFlag | text | I |
| CustGOGSale | text | 0 |
| LaborHours | text | 26.20\|\| |
| BillingHours | text |  |
| TagNo | text |  |
| StockType | text |  |
| ROOpenTime | text | 2026-02-18 00:00:00 |
| CustSUBSale | text | 0 |
| WarrGOGSale | text | 0 |
| WarrSUBSale | text | 0 |
| IntlGOGSale | text | 0 |
| IntlSUBSale | text | 0 |
| TotalGOGCost | text |  |
| TotalGOGSale | text | 0 |
| TotalSUBCost | text |  |
| TotalSUBSale | text | 0 |
| Model# | text |  |
| Transmission | text |  |
| EngineConfig | text |  |
| TrimLevel | text |  |
| PaymentMethod | text | MR\|MR\|MR |
| PickupDate | text |  |
| CustGender | text |  |
| JobStatus | text |  |
| FileName | text | E:\Data\DMS\3_Staging_Service\216452-20260302-SERVICE_correct.csv |
| IsProcessed | true/false | True |
| InsertDate | date and time | 2026-03-02 08:30:26.377000 |
| TekionRecommendationOperationCode | text |  |
| TekionRecommendationOperationDescription | text |  |

