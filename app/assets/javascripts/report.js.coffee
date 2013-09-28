#= require jquery.jqplot.min
#= require plugins/jqplot.barRenderer.min
#= require plugins/jqplot.pieRenderer.min
#= require plugins/jqplot.categoryAxisRenderer.min
#= require plugins/jqplot.pointLabels.min
#= require plugins/jqplot.highlighter.min

$ ->
  defaultHighlighterOptions = {
    show: true,
    tooltipAxes: 'y',
    useAxesFormatters: false,
    tooltipFormatString: '%f p/h',
    fadeTooltip: true,
    tooltipOffset: 4
  }

  data = $('div#chart_data').data()
  if $('#hours_per_project').size() > 0
    $.jqplot 'hours_per_project',
      data.hoursPerProject, {
        title: 'Hours per Project',
        seriesDefaults:{
          renderer: $.jqplot.BarRenderer,
          rendererOptions: {fillToZero: true}
        },
        series: data.projects,
        legend: {
          show: true,
          placement: 'outsideGrid'
        },
        axes: {
          xaxis: {
            renderer: $.jqplot.CategoryAxisRenderer,
            ticks: ['Sprint']
          },
          yaxis: {
            pad: 1.05,
            tickOptions: {formatString: '%d h'}
          }
        },
        highlighter: defaultHighlighterOptions
      }

  if $('#hour_distribution').size() > 0
    $.jqplot 'hour_distribution', data.hourDistribution, {
      title: 'Hour Distribution',
      seriesDefaults: {
        renderer: jQuery.jqplot.PieRenderer,
        rendererOptions: {
          showDataLabels: true
        }
      },
      legend: { show:true, location: 'e' }
    }

  if $('#points_per_project').size() > 0
    $.jqplot 'points_per_project',
      data.pointsPerProject, {
        title: 'Points per Project',
        seriesDefaults:{
          renderer: $.jqplot.BarRenderer,
          rendererOptions: {fillToZero: true}
        },
        series: data.projects,
        legend: {
          show: true,
          placement: 'outsideGrid'
        },
        axes: {
          xaxis: {
            renderer: $.jqplot.CategoryAxisRenderer,
            ticks: ['Sprint']
          },
          yaxis: {
            pad: 1.05,
            tickOptions: {formatString: '%d p'}
          }
        },
        highlighter: defaultHighlighterOptions
      }

  if $('#points_distribution').size() > 0
    $.jqplot 'points_distribution', data.pointsDistribution, {
      title: 'Points Distribution',
      seriesDefaults: {
        renderer: jQuery.jqplot.PieRenderer,
        rendererOptions: {
          showDataLabels: true
        }
      },
      legend: { show:true, location: 'e' }
    }

  if $('#velocity_per_project').size() > 0
    $.jqplot 'velocity_per_project',
      data.velocityPerProject, {
        title: 'Velocity per Project',
        seriesDefaults:{
          renderer: $.jqplot.BarRenderer,
          rendererOptions: {fillToZero: true}
        },
        series: data.projects,
        legend: {
          show: true,
          placement: 'outsideGrid'
        },
        axes: {
          xaxis: {
            renderer: $.jqplot.CategoryAxisRenderer,
            ticks: ['Sprint']
          },
          yaxis: {
            pad: 1.05,
            tickOptions: {formatString: '%d p/h'},
            min: 0,
            tickInterval: 1
          }
        },
        highlighter: defaultHighlighterOptions
      }

  if $('#tickets_per_project').size() > 0
    $.jqplot 'tickets_per_project', data.ticketsPerProject, {
      title: 'Tickets per Project',
      seriesDefaults: {
        renderer: jQuery.jqplot.PieRenderer,
        rendererOptions: {
          showDataLabels: true
        }
      },
      legend: { show:true, location: 'e' }
    }
