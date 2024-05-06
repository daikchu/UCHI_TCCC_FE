$(function(){
  var currencies = [
	{ value: 'nguyễn nghĩa hưng | 135125234', hoten: 'nguyễn nghĩa hưng', cmt: '135125234',noicap: 'cong an Vinh Phuc' },
	{ value: 'Le Quang Truong | 123456789', hoten: 'Le Quang Truong', cmt: '123456789',noicap: 'cong an Ninh Binh' },
  ];
  
  // setup autocomplete function pulling from currencies[] array
  $('#hoten').autocomplete({
    lookup: currencies,
    onSelect: function (suggestion) {
      var thehtml = '<strong>Ho ten:</strong> ' + suggestion.hoten + ' <br> <strong>cmt:</strong> ' + suggestion.cmt + ' <br> <strong>noicap:</strong> ' + suggestion.noicap;
      $('#outputcontent').html(thehtml);
	  
	  $('#hoten').val(suggestion.hoten);
    }
  });

});