// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require materialize-sprockets
//= require materialize-form
//= require vue
//= require best_in_place
//= require_tree .

// @import "materialize";
// @import "https://fonts.googleapis.com/icon?family=Material+Icons";


// Flash fade
$(function() {
   $('.alert-box').fadeIn('normal', function() {
      $(this).delay(3700).fadeOut();
   });
});

// Best in place functionality
$(document).ready(function() {
  jQuery(".best_in_place").best_in_place();
});


// Search submit on enter
$(document).ready(function() {
  function submitForm() {
    document.getElementById("search").submit();
  }
  document.onkeydown = function () {
    if (window.event.keyCode == '13') {
        submitForm();
    }
  }
});

//Highcharts

Highcharts.chart('container', {
    data: {
        table: 'datatable'
    },
    chart: {
        type: 'column'
    },
    title: {
        text: ''
    },
    yAxis: {
        allowDecimals: false,
        title: {
            text: '#'
        }
    },
    tooltip: {
        formatter: function () {
            return '<b>' + this.series.name + '</b><br/>' +
                this.point.y + ' ' + this.point.name.toLowerCase();
        }
    }
});



// Build the chart
Highcharts.chart('container', {
    chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false,
        type: 'pie'
    },
    title: {
        text: 'Crime Breakdown'
    },
    tooltip: {
        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
    },
    plotOptions: {
        pie: {
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels: {
                enabled: false
            },
            showInLegend: true
        }
    },
    series: [{
        name: 'Crimes',
        colorByPoint: true,
        data: [{
            name: 'Murder',
            y: 42.2,
            sliced: true,
            selected: true
        }, {
            name: 'Arson',
            y: 21.84
        }, {
            name: 'Drugs',
            y: 10.85
        }, {
            name: 'Kidnapping',
            y: 2.67
        }, {
            name: 'Assualt and Battery',
            y: 4.28
        }, {
            name: 'Misdemeanor',
            y: 17.16
        }, {
            name: 'Crime',
            y: 38.05
        }]
    }]
});


