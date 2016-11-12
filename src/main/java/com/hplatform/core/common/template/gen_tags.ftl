<#if column.plugin=="587c1da1c19049e28577cfe988cef9b9">
<form:input<#list column.columnElements as columnElement> ${columnElement.element.elementName}="<#if isEL(columnElement.elementValue)>${'$'}{${trimEL(columnElement.elementValue)?eval}}<#elseif columnElement.elementValue?contains('.')>${columnElement.elementValue?eval}<#else>${columnElement.elementValue}</#if>"</#list>/>
<#elseif column.plugin=="1db4e28fa5264429a4c9693fdad3eaa1">
<form:select<#list column.columnElements as columnElement> ${columnElement.element.elementName}="<#if isEL(columnElement.elementValue)>${'$'}{${trimEL(columnElement.elementValue)?eval}}<#elseif columnElement.elementValue?contains('.')>${columnElement.elementValue?eval}<#else>${columnElement.elementValue}</#if>"</#list>></form:select>
<#elseif column.plugin=="b429024598fe4c00880e88292d8481ef">
<form:textarea<#list column.columnElements as columnElement> ${columnElement.element.elementName}="<#if isEL(columnElement.elementValue)>${'$'}{${trimEL(columnElement.elementValue)?eval}}<#elseif columnElement.elementValue?contains('.')>${columnElement.elementValue?eval}<#else>${columnElement.elementValue}</#if>"</#list>/>
<#elseif column.plugin=="8b4c8d499e324d8aa096eb21b6a9c552">
<form:hidden<#list column.columnElements as columnElement> ${columnElement.element.elementName}="<#if isEL(columnElement.elementValue)>${'$'}{${trimEL(columnElement.elementValue)?eval}}<#elseif columnElement.elementValue?contains('.')>${columnElement.elementValue?eval}<#else>${columnElement.elementValue}</#if>"</#list>/>
<#elseif column.plugin=="e27cd759855c4a0c8cd841d5241de654">
<form:checkbox<#list column.columnElements as columnElement> ${columnElement.element.elementName}="<#if isEL(columnElement.elementValue)>${'$'}{${trimEL(columnElement.elementValue)?eval}}<#elseif columnElement.elementValue?contains('.')>${columnElement.elementValue?eval}<#else>${columnElement.elementValue}</#if>"</#list>/>
<#elseif column.plugin=="58e92e109b0448b3951913b65b6955c7">
<form:label<#list column.columnElements as columnElement> ${columnElement.element.elementName}="<#if isEL(columnElement.elementValue)>${'$'}{${trimEL(columnElement.elementValue)?eval}}<#elseif columnElement.elementValue?contains('.')>${columnElement.elementValue?eval}<#else>${columnElement.elementValue}</#if>"</#list>/>
<#elseif column.plugin=="a3ed719e7c134ecc8017c85e651597ab">
<form:password<#list column.columnElements as columnElement> ${columnElement.element.elementName}="<#if isEL(columnElement.elementValue)>${'$'}{${trimEL(columnElement.elementValue)?eval}}<#elseif columnElement.elementValue?contains('.')>${columnElement.elementValue?eval}<#else>${columnElement.elementValue}</#if>"</#list>/>
<#elseif column.plugin=="a257abedbd9f449abf3db63d9e584687">
<form:radiobutton<#list column.columnElements as columnElement> ${columnElement.element.elementName}="<#if isEL(columnElement.elementValue)>${'$'}{${trimEL(columnElement.elementValue)?eval}}<#elseif columnElement.elementValue?contains('.')>${columnElement.elementValue?eval}<#else>${columnElement.elementValue}</#if>"</#list>/>
<#elseif column.plugin=="814ce70dd3a54b609992b66ac0407c1d">
<form:radiobuttons<#list column.columnElements as columnElement> ${columnElement.element.elementName}="<#if isEL(columnElement.elementValue)>${'$'}{${trimEL(columnElement.elementValue)?eval}}<#elseif columnElement.elementValue?contains('.')>${columnElement.elementValue?eval}<#else>${columnElement.elementValue}</#if>"</#list>/>
<#elseif column.plugin=="6093dbcf5e59462294a135e973c5e055">
<input<#list column.columnElements as columnElement> ${columnElement.element.elementName}="<#if isEL(columnElement.elementValue)>${'$'}{${trimEL(columnElement.elementValue)?eval}}<#elseif columnElement.elementValue?contains('.')>${columnElement.elementValue?eval}<#else>${columnElement.elementValue}</#if>"</#list>/>
<#elseif column.plugin=="96bb041317ec4d7281142201f5a0ac33">
<select<#list column.columnElements as columnElement> ${columnElement.element.elementName}="<#if isEL(columnElement.elementValue)>${'$'}{${trimEL(columnElement.elementValue)?eval}}<#elseif columnElement.elementValue?contains('.')>${columnElement.elementValue?eval}<#else>${columnElement.elementValue}</#if>"</#list>></select>
<#elseif column.plugin=="b9da5ff4ca3f4dda920fb3ee7ea8880b">
<textarea<#list column.columnElements as columnElement> ${columnElement.element.elementName}="<#if isEL(columnElement.elementValue)>${'$'}{${trimEL(columnElement.elementValue)?eval}}<#elseif columnElement.elementValue?contains('.')>${columnElement.elementValue?eval}<#else>${columnElement.elementValue}</#if>"</#list>></textarea>
<#elseif column.plugin=="c47f545bdb854584ae2fa3fc9e0645ca">
<tags:editor<#list column.columnElements as columnElement> ${columnElement.element.elementName}="<#if isEL(columnElement.elementValue)>${'$'}{${trimEL(columnElement.elementValue)?eval}}<#elseif columnElement.elementValue?contains('.')>${columnElement.elementValue?eval}<#else>${columnElement.elementValue}</#if>"</#list>></tags:editor>
<#elseif column.plugin=="0673cb287bc048fa8f44f2a823f49f11">
<tags:date<#list column.columnElements as columnElement> ${columnElement.element.elementName}="<#if isEL(columnElement.elementValue)>${'$'}{${trimEL(columnElement.elementValue)?eval}}<#elseif columnElement.elementValue?contains('.')>${columnElement.elementValue?eval}<#else>${columnElement.elementValue}</#if>"</#list>></tags:date>
<#elseif column.plugin=="7e75a40a48d347b6ad01cc561b58a080">
<tags:webuploader<#list column.columnElements as columnElement> ${columnElement.element.elementName}="<#if isEL(columnElement.elementValue)>${'$'}{${trimEL(columnElement.elementValue)?eval}}<#elseif columnElement.elementValue?contains('.')>${columnElement.elementValue?eval}<#else>${columnElement.elementValue}</#if>"</#list>></tags:webuploader>
<#elseif column.plugin=="2a3daba88ae24a07891240835376dc16">
<tags:area<#list column.columnElements as columnElement> ${columnElement.element.elementName}="<#if isEL(columnElement.elementValue)>${'$'}{${trimEL(columnElement.elementValue)?eval}}<#elseif columnElement.elementValue?contains('.')>${columnElement.elementValue?eval}<#else>${columnElement.elementValue}</#if>"</#list>></tags:area>
</#if>