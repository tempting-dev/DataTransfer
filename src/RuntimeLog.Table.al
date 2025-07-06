table 50105 "Runtime Log"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Entry No.';
        }

        field(2; "Start Time"; DateTime)
        {
            Caption = 'Start Time';
        }

        field(3; "End Time"; DateTime)
        {
            Caption = 'End Time';
        }

        field(4; "Duration (ms)"; Integer)
        {
            Caption = 'Duration (ms)';
        }

        field(5; Message; Text[250])
        {
            Caption = 'Message';
        }

        field(6; "Session ID"; Integer)
        {
            Caption = 'Session ID';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Start Time")
        {

        }
    }
}