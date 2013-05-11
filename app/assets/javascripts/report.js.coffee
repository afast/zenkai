#= require jquery.jqplot.min
$ ->
  $.jqplot 'error', $('div#error').data('error'), {title: 'Error % history', axes: { xaxis: {label: 'Sprint'}, yaxis: {label: 'Error %'}}}
  $.jqplot 'deviation', $('div#deviation').data('deviation'), {title: 'Deviation History', axes: { xaxis: {label: 'Sprint'}, yaxis: {label: 'Deviation h'}}}
