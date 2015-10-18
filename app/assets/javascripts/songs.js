/**
 *
 * Created by mikefarr on 7/10/15.
 */

$(document).ready(function () {


    $('#song-container').on('click', '#edit-song', function (event) {
        event.preventDefault();

        $('#left-column').hide();
        $('#left-edit-column').show();
    });

    $('#song-container').on('click', '#cancel-edit-song', function (event) {
        event.preventDefault();

        $('#left-column').show();
        $('#left-edit-column').hide();
    });

});
