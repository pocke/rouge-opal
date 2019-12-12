require 'native'


%x{
  var dom = document.querySelector('#main');
}

content = '@foo = 1'.force_encoding(Encoding::UTF_8)
Native(dom).innerHTML = Rouge.highlight(content, 'ruby', 'html')
