/**
 * Created by mikefarr on 10/4/15.
 */
$(document).ready(function () {

    $('#add-song')
        .modal('attach events', '#add-song-btn', 'show')
        .modal({
            closable: false,
            onDeny: function () {
                return true;
            },
            onApprove: function () {
                event.preventDefault();
                //window.alert('Approved!');

                // 3) capture the URL we submit to
                var path = $('form#get-song').attr("action");
                //var var_array = $('form#get-song'); var_array[0].push({performance_id : $('#returned-songs').attr('data-performance')}); var values = var_array.serialize();    //get the form data

                var values = $('form#get-song').serialize();    //get the form data
                $.ajax({
                    url: path,
                    type: "POST",
                    dataType: "html",
                    data: values
                })
                    .done(function (response) {
                        // 7) add the returned data to the page
                        console.log(response);
                        $("#returned-songs").html(response);

                    })
                    .fail(function (response) {
                        alert("Error" + response);
                    })
                    .always(function (response) {
                        // 7) add the returned data to the page
                        console.log(response);
                        $("#returned-songs").html(response);

                    })
                return false;

            }
        })
});
