$ ->
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
        
        $(input).typeahead({
            source: option,
            updater: (item) ->
                $(input).val(item)
                $('.navbar form').submit()
                return item
        });

    $('[rel="tooltip"]').each ->
        $(this).tooltip()