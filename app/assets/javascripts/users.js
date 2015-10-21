$(document)
    .ready(function () {
        var validations = {
            fields: {
                name: {
                    identifier: 'user[name]',
                    rules: [
                        {type: 'empty', prompt: 'Please enter your name'}
                    ]
                },
                voice: {
                    identifier: 'user[voice]',
                    rules: [
                        {type: 'empty', prompt: 'Please enter voice section'}
                    ]
                },
                username: {
                    identifier: 'user[username]',
                    rules: [
                        {type: 'empty', prompt: 'Please enter a username'},
                        {type: 'length[5]', prompt: 'Your username must be at least 5 characters'}
                    ]
                },
                email: {
                    identifier: 'user[email]',
                    rules: [
                        {type: 'email', prompt: 'Please enter a valid e-mail'}
                    ]
                },
                password: {
                    identifier: 'user[password]',
                    rules: [
                        {type: 'empty', prompt: 'Please enter a password'},
                        {type: 'length[6]', prompt: 'Your password must be at least 6 characters'}
                    ]
                },
                passwordConfirm: {
                    identifier: 'password-confirm',
                    rules: [
                        {
                            type: 'empty',
                            prompt: 'Please confirm your password'
                        },
                        {
                            identifier: 'password-confirm',
                            type: 'match[user[password]]',
                            prompt: 'Please verify password matches'
                        }
                    ]
                }
            }
        };

        //var settings = {
        //    inline: true,
        //    onFailure: function () {
        //        return false;
        //    }
        //    //,
        //    //onSuccess: function () {
        //    //    //    //do some ajax here, or maybe don't need it, just return it
        //    //    $('#to-slide-up').slideUp(400);
        //    //    $('#terms').hide();
        //    //    $('.ui.segment.inverted.green').show();
        //    //    return false;
        //    //}
       // };

        $('#user-edit-box').form(validations);
        $('.ui.selection.dropdown')
            .dropdown()
        ;
    }
);