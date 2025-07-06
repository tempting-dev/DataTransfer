page 50101 Test
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(PopulateTestData)
            {
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    TestData: Record "Test Data";
                    RuntimeTracker: Codeunit "Runtime Tracker";
                    TrackingId: Integer;
                    i: Integer;

                begin
                    TrackingId := RuntimeTracker.StartTracking('Populating 1,000,000 test records');

                    for i := 1 to 1000000 do begin
                        Clear(TestData);
                        TestData.Init();
                        TestData.MyId := CreateGuid();
                        TestData.MyTextField := 'Test ' + Format(i);
                        TestData.Insert(true);
                    end;

                    RuntimeTracker.StopTracking(TrackingId);
                    Message('Test data population completed. Check Runtime Log for performance details.');
                end;
            }

        }
        area(Navigation)
        {
            action(GoToTestData)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Page.Run(Page::"Test Data Page");
                end;
            }

            action(GoToTestDataClassic)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Page.Run(Page::"Test Data Classic");
                end;
            }

            action(GoToTestDataTransfer)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Page.Run(Page::"Test Data Transfer");
                end;
            }

            action(GoToRuntimeLog)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Runtime Log';

                trigger OnAction()
                begin
                    Page.Run(Page::"Runtime Log");
                end;
            }
        }
    }

    var
        myInt: Integer;
}