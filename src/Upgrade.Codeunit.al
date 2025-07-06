codeunit 50101 Upgrade
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    begin
        //ProcessClassicWay();
        //ProcessWithDataTransfer();
        CopyMyIdToMyId2();
        InitializeStatusField();
        InitializeFieldWithFilters();
    end;

    local procedure ProcessWithDataTransfer()
    var
        TestData: Record "Test Data";
        TestDataTransfer: Record "Test Data Transfer";
        RuntimeTrakcker: Codeunit "Runtime Tracker";
        DataTransfer: DataTransfer;
        TrackingId: Integer;
    begin
        TestDataTransfer.DeleteAll();
        TrackingId := RuntimeTrakcker.StartTracking(StrSubstNo('Processing %1 records new way', TestData.Count()));
        DataTransfer.SetTables(Database::"Test Data", Database::"Test Data Transfer");
        DataTransfer.AddFieldValue(TestData.FieldNo("Entry No."), TestDataTransfer.FieldNo("Entry No."));
        DataTransfer.AddFieldValue(TestData.FieldNo(MyTextField), TestDataTransfer.FieldNo(MyTextField));
        DataTransfer.AddFieldValue(TestData.FieldNo(MyId), TestDataTransfer.FieldNo(MyId));
        DataTransfer.AddFieldValue(TestData.FieldNo(SystemId), TestDataTransfer.FieldNo(SystemId));
        DataTransfer.AddFieldValue(TestData.FieldNo(SystemCreatedAt), TestDataTransfer.FieldNo(SystemCreatedAt));
        DataTransfer.AddFieldValue(TestData.FieldNo(SystemCreatedBy), TestDataTransfer.FieldNo(SystemCreatedBy));
        DataTransfer.AddFieldValue(TestData.FieldNo(SystemModifiedAt), TestDataTransfer.FieldNo(SystemModifiedAt));
        DataTransfer.AddFieldValue(TestData.FieldNo(SystemModifiedBy), TestDataTransfer.FieldNo(SystemModifiedBy));
        DataTransfer.CopyRows();
        RuntimeTrakcker.StopTracking(TrackingId);
    end;

    local procedure ProcessClassicWay()
    var
        TestData: Record "Test Data";
        TestDataClassic: Record "Test Data Classic";
        RuntimeTrakcker: Codeunit "Runtime Tracker";
        TrackingId: Integer;
    begin
        TestDataClassic.DeleteAll();

        TrackingId := RuntimeTrakcker.StartTracking(StrSubstNo('Processing %1 records classic way', TestData.Count()));
        if TestData.FindSet() then
            repeat
                TestDataClassic.TransferFields(TestData, true);
                TestDataClassic.Insert();
            until TestData.Next() = 0;

        RuntimeTrakcker.StopTracking(TrackingId);
    end;

    local procedure CopyMyIdToMyId2()
    var
        TestData: Record "Test Data";
        RuntimeTracker: Codeunit "Runtime Tracker";
        DataTransfer: DataTransfer;
        TrackingId: Integer;
    begin
        TrackingId := RuntimeTracker.StartTracking('Copying MyId to MyId2');
        DataTransfer.SetTables(Database::"Test Data", Database::"Test Data");
        DataTransfer.AddFieldValue(TestData.FieldNo(MyId), TestData.FieldNo(MyId2));
        DataTransfer.CopyFields();
        RuntimeTracker.StopTracking(TrackingId);
    end;

    local procedure InitializeStatusField()
    var
        TestData: Record "Test Data";
        RuntimeTracker: Codeunit "Runtime Tracker";
        DataTransfer: DataTransfer;
        TrackingId: Integer;
        DefaultStatus: Code[10];
    begin
        DefaultStatus := 'NEW';
        TrackingId := RuntimeTracker.StartTracking(StrSubstNo('Initializing Status field for %1 records', TestData.Count()));
        DataTransfer.SetTables(Database::"Test Data", Database::"Test Data");
        DataTransfer.AddConstantValue(DefaultStatus, TestData.FieldNo("Status"));
        DataTransfer.CopyFields();
        RuntimeTracker.StopTracking(TrackingId);
    end;

    local procedure InitializeFieldWithFilters()
    var
        TestData: Record "Test Data";
        RuntimeTracker: Codeunit "Runtime Tracker";
        DataTransfer: DataTransfer;
        TrackingId: Integer;
        DefaultStatus: Code[10];
    begin
        TrackingId := RuntimeTracker.StartTracking(StrSubstNo('Initializing Status field for %1 records', TestData.Count()));
        DataTransfer.SetTables(Database::"Test Data", Database::"Test Data");
        DataTransfer.AddConstantValue('Hello World!', TestData.FieldNo("MyTextField2"));
        DataTransfer.AddSourceFilter(TestData.FieldNo("Entry No."), '<%1', 1000);
        DataTransfer.CopyFields();
        RuntimeTracker.StopTracking(TrackingId);
    end;


}