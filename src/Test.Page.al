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

            action(PopulateDocumentTestData)
            {
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Populate Document Test Data';

                trigger OnAction()
                var
                    DocumentHeader: Record "Document Header";
                    DocumentLine: Record "Document Line";
                    RuntimeTracker: Codeunit "Runtime Tracker";
                    TrackingId: Integer;
                    i: Integer;
                    j: Integer;
                    LineCount: Integer;

                begin
                    TrackingId := RuntimeTracker.StartTracking('Populating 1,000,000 document headers with lines');

                    for i := 1 to 1000000 do begin
                        // Create Document Header
                        Clear(DocumentHeader);
                        DocumentHeader.Init();
                        DocumentHeader."No." := 'DOC' + Format(i, 0, '<Integer,7><Filler Character,0>');
                        DocumentHeader."Document Date" := Today();
                        DocumentHeader."Customer No." := 'CUST' + Format((i mod 1000) + 1, 0, '<Integer,4><Filler Character,0>');
                        DocumentHeader."Description" := 'Document Header ' + Format(i);
                        DocumentHeader.Insert(true);

                        // Create random number of lines (1-50)
                        LineCount := Random(50) + 1;
                        for j := 1 to LineCount do begin
                            Clear(DocumentLine);
                            DocumentLine.Init();
                            DocumentLine."Document No." := DocumentHeader."No.";
                            DocumentLine."Line No." := j * 10000;
                            DocumentLine.Description := 'Line ' + Format(j) + ' for Document ' + Format(i);
                            DocumentLine.Insert(true);
                        end;
                    end;

                    RuntimeTracker.StopTracking(TrackingId);
                    Message('Document test data population completed. Check Runtime Log for performance details.');
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