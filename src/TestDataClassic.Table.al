table 50102 "Test Data Classic"
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
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }



}