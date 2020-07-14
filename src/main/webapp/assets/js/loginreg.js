/**
 *
 */

$('input[type="text"], input[type="password"]').focus(function() {
    $("#loginreg-error-tip").addClass("vh");
    $(this).parent(".info-container").addClass("is-focused");
});

/**
 *
 */
$('input[type="text"], input[type="password"]').blur(function() {
    $(this).parent(".info-container").removeClass("is-focused");
});
