<html>
<head>
<script type="text/javascript">
  function sendEvent(event) {
    this_form = document.forms[0];
    this_form.EVENT.value = event;
    this_form.submit();
  }
</script>
</head>
<body> 
  <form action=[% ACTION %] method='post'>
  <input type="hidden" name="EVENT"/>

  <h1> Please select a state to display its capital and population. </h1>
  States: <select name="STATES" onChange="sendEvent('SUBMIT_DATA')">[% STATES_DROPDOWN %]></select><br/><br/>

  [% IF CAPITAL %]Capital: [% CAPITAL %][% END %]
  <br/><br/>

  [% IF POPULATION %]Population: [% POPULATION %][% END %]

  </form>
</body>
</html>
