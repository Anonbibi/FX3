AddEventHandler( 'chatMessage', function( source, n, msg )  
    
    if ( msg == "/wanted" ) then 
    
        CancelEvent() 

        TriggerClientEvent( 'allowWanted', -1 )
        TriggerEvent("chatMessage", "", { 0, 0, 0 }, "Never Wanted Toggled!")
    end
end )

AddEventHandler('rconCommand', function(commandName, args)
    if commandName:lower() == 'wanted' then
        TriggerClientEvent( 'allowWanted', -1 )
        TriggerEvent("chatMessage", "", { 0, 0, 0 }, "Never Wanted Toggled!")
        
        CancelEvent()
    end
end)