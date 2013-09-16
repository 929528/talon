$ ->
    # Autocomplete add
	$('select[rel="autocomplete"]').each ->
        option = []     
        $(this).find('option').each ->     
            option.push $(this).text()
        
        input = $('<input>')
        input.attr('type','text')
        input.attr('name', $(this).attr('name') )
        input.attr('id', $(this).attr('id') )  
        input.attr('class', $(this).attr('class') )
        input.attr('placeholder', $(this).attr('placeholder') )
        input.attr('data-provide', 'typeahead' )
        input.attr('autocomplete', 'off' )
        input.val($(this).attr('data_default'))
        $(this).replaceWith(input)
        
        $(input).typeahead
            source: option,
            updater: (item) ->
                $(input).val(item)
                $('.navbar form').submit()
                return item

    # Tooltip add        
    $('[rel="tooltip"]').each ->
        $(this).tooltip()

    # Submit modal form
    $('#modal-window').on 'shown', () ->
        modal = $(this)
        $('.modal-footer > .btn').each ->
            $(this).click () ->
                state = $(this).data('state')
                if  state == "close"
                    modal.modal('hide')
                else
                    $('.modal-body > .form > form #document_document_state_name').val(state)

                    $('.modal-body > .form > form').submit()
 
    #Validate exists DOM.id
    submit_barcode_form = () ->
        barcode = $('#request_barcode').val()
        operations = $('.operation')
        for el in operations
            if el.id == barcode
                error = "Талон существует в списке"
        unless error 
            ('#request').submit()
        else
            show_error(error)
            $('#request_barcode').val('')

    show_error = (error) ->
        $("#form_errors").html('<div class="alert alert-error">'+error+'</div>')
        $("#form_errors").show(300).delay(1000).hide(300)

    # Add to window functions
    window.submit_barcode_form = submit_barcode_form