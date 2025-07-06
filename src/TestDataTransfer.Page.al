page 50106 "Test Data Transfer"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Test Data Transfer";

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {

                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field(MyTextField; Rec.MyTextField)
                {
                    ToolTip = 'Specifies the value of the MyTextField field.', Comment = '%';
                }
                field(MyId; Rec.MyId)
                {
                    ToolTip = 'Specifies the value of the MyId field.', Comment = '%';
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                }
                field(SystemCreatedBy; Rec.SystemCreatedBy)
                {
                    ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                }
                field(SystemId; Rec.SystemId)
                {
                    ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                }
                field(SystemModifiedAt; Rec.SystemModifiedAt)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                }
                field(SystemModifiedBy; Rec.SystemModifiedBy)
                {
                    ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                }
            }
        }



    }
}