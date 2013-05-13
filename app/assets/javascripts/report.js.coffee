#= require jquery.jqplot.min
$ ->
  if $('#error').size() > 0
    $.jqplot 'error', $('div#error').data('error'), {title: 'Error % history', axes: { xaxis: {label: 'Sprint'}, yaxis: {label: 'Error %'}}}
  if $('#deviation').size() > 0
    $.jqplot 'deviation', $('div#deviation').data('deviation'), {title: 'Deviation History', axes: { xaxis: {label: 'Sprint'}, yaxis: {label: 'Deviation h'}}}
