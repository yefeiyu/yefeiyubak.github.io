---
layout: default
title: Search
permalink: /search/
---
<div id="search">
  <form action="/search" method="get">
    <input type="text" id="search-query" name="q" placeholder="Search" autocomplete="off">
  </form>
</div>

<script src="/js/search.min.js" type="text/javascript" charset="utf-8"></script>


<section id="search-results" style="display: none;">
  <p>Search results</p>
  <div class="entries">
  </div>
</section>

<script type="text/javascript">
  $(function() {
    $('#search-query').lunrSearch({
      indexUrl  : '/js/index.json',           // url for the .json file containing search index data// URL of the `search.json` index data for your site
      results   : '#search-results',          // selector for containing search results element// jQuery selector for the search results container
      template  : '#search-results-template', // selector for Mustache.js template// jQuery selector for the Mustache.js template
      titleMsg  : '<h1>Search results<h1>',   // message attached in front of results (can be empty)
      emptyMsg  : '<p>Nothing found.</p>'     // shown message if search returns no results
//      entries:  '.entries',                 // jQuery selector for the element to contain the results list, must be a child of the results element above.	
    });
  });
</script>

<script src="/js/search.min.js" type="text/javascript" charset="utf-8"></script>

{% raw %}
<script id="search-results-template" type="text/mustache">
  {{#entries}}
    <article>
      <h2>
        {{#date}}<small><time datetime="{{pubdate}}" pubdate>{{displaydate}}</time></small>{{/date}}
        <a href="{{url}}">{{title}}</a>
      </h2>
      {{#is_post}}
      <ul>
{{#tags}} <small> {{.}} </small>{{/tags}}
      </ul>
      {{/is_post}}
    </article>
  {{/entries}}
</script>
{% endraw %}
