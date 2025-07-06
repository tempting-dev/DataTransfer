codeunit 50101 Upgrade
{
    Subtype = Upgrade;

    trigger OnUpgradePerCompany()
    begin
        ProcessClassicWay();
        ProcessWithDataTransfer();
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

}