<!DOCTYPE html>
<html>
<head>
  <meta charSet='utf-8' />
  <title>{{config.title + ' - ' + page.title}}</title>
  <link href='https://cdnjs.cloudflare.com/ajax/libs/normalize/4.0.0/normalize.min.css' rel='stylesheet' type='text/css'>
  <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,300,700' rel='stylesheet' type='text/css'>
  <link href='{{ url_for("css/docs.css") }}' rel='stylesheet'>
</head>
<body>
  <div class='menu'>
    <div class='logo'>
      <a href="https://www.github.com/hcnode/koa-cola"><img src="/doc/images/github.png" width="25"></a>&nbsp;&nbsp;Koa-cola
    </div>
    <nav class='menu-nav' style="overflow-y: scroll;max-height: 87%;">
      {% for section in site.data.nav %}
        <ul class='nav'>
          <span>{{ section.title }}</span>
          <ul class='nav'>
            {% for item in section.items %}
              <li>
              {% if item.items %}
                <a href='{{item.href || url_for(item.id + ".html") }}'{% if item.id == page.id %} class='active'{% endif %} style="padding:0px">{{item.title}}</a>
                <ul class='nav' style="padding-top:0px">
                  {% for item2 in item.items %}
                    <li style="height:28px">
                      <a href='{{item2.href || url_for(item2.id + ".html") }}'{% if item2.id == page.id %} class='active'{% endif %}>{{item2.title}}</a>
                    </li>
                  {% endfor %}
                </ul>
              {% else %}
                 <a href='{{item.href || url_for(item.id + ".html") }}'{% if item.id == page.id %} class='active'{% endif %}>{{item.title}}</a>
              {% endif %}
              </li>
            {% endfor %}
          </ul>
        </ul>
      {% endfor %}
    </nav>
  </div>
  <div class='page'>
    <div class='page-content'>
      <h1>{{page.title}}</h1>
      {{page.content}}
    </div>
  </div>
  <div class='switch-page'>
    {% if page.prev %}
      <a class='previous' href='{{ url_for(page.prev) }}'>Previous</a>
    {% endif %}
    {% if page.next %}
      <a class='next' href='{{ url_for(page.next) }}'>Next</a>
    {% endif %}
  </div>
</body>
</html>
