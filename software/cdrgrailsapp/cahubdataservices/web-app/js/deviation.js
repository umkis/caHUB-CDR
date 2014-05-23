/* Please do not check in commented out code like alert(flags), partial code etc. */

$(document).ready(function() {
    $("#progressBtn").click(function() {
        return confirm("Are you sure you want to mark this Deviation as In Progress?");
    });
    
    $("#resolveBtn").click(function() {
        return confirm("Are you sure you want to mark this Deviation as Resolved?");
    });
    
    $("#reopenBtn").click(function() {
        return confirm("Are you sure you want to reopen this Deviation?");
    });
    
    $("#closeBtn").click(function() {
        return confirm("Are you sure you want to close this Deviation?");
    });
    
    $("#invalidateBtn").click(function() {
        return confirm("Are you sure you want to invalidate this Deviation?");
    });
    
    $("#addResponseBtn").button().click(function() {
        $("#responseDialog").dialog("open");
        $("#response").val("");
    });

    $("#saveResponseBtn").click(function() {
        $("#responseDialog").dialog("close");
    });
    
    $("#cancelResponseBtn").click(function() {
        $("#responseDialog").dialog("close");
    });

    $("#responseDialog").dialog({
        autoOpen: false,
        height: 150,
        width: 930,
        modal: true,
        buttons: {},
        close: function() {}
    });
    
    $("#studyId").change(function() {
        $("#studyFilter").submit(); 
    });
});
