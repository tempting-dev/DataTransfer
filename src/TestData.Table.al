table 50100 "Test Data"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }

        field(2; MyTextField; Text[100])
        {

        }

        field(3; MyId; Guid)
        {

        }

        field(4; MyId2; Guid)
        {

        }

        field(5; "Status"; Code[10])
        {

        }

        field(6; MyTextField2; Text[100])
        {

        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }



}