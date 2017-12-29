class HomeController < ApplicationController
  def welcome
    # Yearly summary graph:
    gon.data = Invoice.yearly_summary_graph_data(current_user)
    options  = {
      title: t('graphs.yearly_summary.title'),
      hAxis: {
        title: t('graphs.yearly_summary.x-title'),
        gridlines: {
          count: 8
        }
      },
      vAxis: {
        title: t('graphs.yearly_summary.y-title')
      },
      download: true,
      animation:{
        duration: 1000,
        easing: 'out',
      }
    }
    gon.options = options
  end
end
