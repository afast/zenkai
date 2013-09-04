#= require jquery.jqplot.min
#= require plugins/jqplot.barRenderer.min
#= require plugins/jqplot.pieRenderer.min
#= require plugins/jqplot.categoryAxisRenderer.min
#= require plugins/jqplot.pointLabels.min

$ ->
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
        }
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
        }
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
            tickOptions: {formatString: '%d p'}
          }
        }
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
