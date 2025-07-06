codeunit 50100 "Runtime Tracker"
{
    var
        StartTimeDict: Dictionary of [Integer, DateTime];
        MessageDict: Dictionary of [Integer, Text[250]];
        CurrentTrackingId: Integer;

    procedure StartTracking(Message: Text[250]): Integer
    var
        TrackingId: Integer;
    begin
        CurrentTrackingId += 1;
        TrackingId := CurrentTrackingId;

        StartTimeDict.Set(TrackingId, CurrentDateTime);
        MessageDict.Set(TrackingId, Message);

        exit(TrackingId);
    end;

    procedure StopTracking(TrackingId: Integer)
    var
        RuntimeLog: Record "Runtime Log";
        StartTime: DateTime;
        EndTime: DateTime;
        Message: Text[250];
        Duration: Integer;
    begin
        if not StartTimeDict.Get(TrackingId, StartTime) then
            Error('Tracking ID %1 not found. Make sure StartTracking was called first.', TrackingId);

        EndTime := CurrentDateTime;
        MessageDict.Get(TrackingId, Message);

        Duration := EndTime - StartTime;

        RuntimeLog.Init();
        RuntimeLog."Start Time" := StartTime;
        RuntimeLog."End Time" := EndTime;
        RuntimeLog."Duration (ms)" := Duration;
        RuntimeLog.Message := Message;
        RuntimeLog."Session ID" := SessionId;
        RuntimeLog.Insert(true);

        // Clean up dictionaries
        StartTimeDict.Remove(TrackingId);
        MessageDict.Remove(TrackingId);
    end;

    procedure StopTrackingWithMessage(TrackingId: Integer; AdditionalMessage: Text[250])
    var
        RuntimeLog: Record "Runtime Log";
        StartTime: DateTime;
        EndTime: DateTime;
        OriginalMessage: Text[250];
        FinalMessage: Text[250];
        Duration: Integer;
    begin
        if not StartTimeDict.Get(TrackingId, StartTime) then
            Error('Tracking ID %1 not found. Make sure StartTracking was called first.', TrackingId);

        EndTime := CurrentDateTime;
        MessageDict.Get(TrackingId, OriginalMessage);

        if AdditionalMessage <> '' then
            FinalMessage := OriginalMessage + ' - ' + AdditionalMessage
        else
            FinalMessage := OriginalMessage;

        Duration := EndTime - StartTime;

        RuntimeLog.Init();
        RuntimeLog."Start Time" := StartTime;
        RuntimeLog."End Time" := EndTime;
        RuntimeLog."Duration (ms)" := Duration;
        RuntimeLog.Message := FinalMessage;
        RuntimeLog."Session ID" := SessionId;
        RuntimeLog.Insert(true);

        // Clean up dictionaries
        StartTimeDict.Remove(TrackingId);
        MessageDict.Remove(TrackingId);
    end;
}