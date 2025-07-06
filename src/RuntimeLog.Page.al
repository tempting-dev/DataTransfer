page 50105 "Runtime Log"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Runtime Log";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Start Time"; Rec."Start Time")
                {
                    ApplicationArea = All;
                }
                field("End Time"; Rec."End Time")
                {
                    ApplicationArea = All;
                }
                field("Duration (ms)"; Rec."Duration (ms)")
                {
                    ApplicationArea = All;
                }
                field(Message; Rec.Message)
                {
                    ApplicationArea = All;
                }
                field("Session ID"; Rec."Session ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ClearLogs)
            {
                ApplicationArea = All;
                Caption = 'Clear All Logs';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to delete all runtime logs?') then begin
                        Rec.DeleteAll();
                        CurrPage.Update();
                    end;
                end;
            }
        }
    }
}