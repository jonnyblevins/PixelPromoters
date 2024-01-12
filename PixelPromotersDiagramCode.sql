CREATE TABLE "Social Media"(
    "PlatformID" INT NOT NULL,
    "PlatformName" VARCHAR(255) NOT NULL,
    "Characteristics" DECIMAL(8, 2) NOT NULL
);
ALTER TABLE
    "Social Media" ADD CONSTRAINT "social media_platformid_primary" PRIMARY KEY("PlatformID");
CREATE TABLE "Campaign"(
    "CampaignID" INT NOT NULL,
    "ClientID" INT NOT NULL,
    "CampaignStartDate" DATE NOT NULL,
    "CampaignEndDate" DATE NOT NULL,
    "Budget" DECIMAL(8, 2) NOT NULL,
    "Objective" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "Campaign" ADD CONSTRAINT "campaign_campaignid_primary" PRIMARY KEY("CampaignID");
CREATE TABLE "Department"(
    "DepartmentID" INT NOT NULL,
    "DepartmentName" VARCHAR(255) NOT NULL,
    "ManagerID" INT NOT NULL
);
ALTER TABLE
    "Department" ADD CONSTRAINT "department_departmentid_primary" PRIMARY KEY("DepartmentID");
CREATE TABLE "Employee"(
    "EmployeeID" INT NOT NULL,
    "Name" VARCHAR(255) NOT NULL,
    "DepartmentID" INT NOT NULL,
    "JobRole" VARCHAR(255) NOT NULL,
    "Salary" DECIMAL(8, 2) NOT NULL,
    "HireDate" DATE NOT NULL,
    "Employed" TINYINT NOT NULL
);
ALTER TABLE
    "Employee" ADD CONSTRAINT "employee_employeeid_primary" PRIMARY KEY("EmployeeID");
CREATE TABLE "Client"(
    "ClientID" INT NOT NULL,
    "CompanyName" VARCHAR(255) NOT NULL,
    "ContactInfo" VARCHAR(255) NULL,
    "ContractStartDate" DATE NOT NULL,
    "ContractEndDate" DATE NOT NULL
);
ALTER TABLE
    "Client" ADD CONSTRAINT "client_clientid_primary" PRIMARY KEY("ClientID");
ALTER TABLE
    "Employee" ADD CONSTRAINT "employee_departmentid_foreign" FOREIGN KEY("DepartmentID") REFERENCES "Department"("DepartmentID");
ALTER TABLE
    "Department" ADD CONSTRAINT "department_managerid_foreign" FOREIGN KEY("ManagerID") REFERENCES "Employee"("EmployeeID");
ALTER TABLE
    "Campaign" ADD CONSTRAINT "campaign_clientid_foreign" FOREIGN KEY("ClientID") REFERENCES "Client"("ClientID");