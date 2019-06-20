showServeyChart();

function showServeyChart() {
  $.ajax({
    type: "GET",
    url: `/costs/survey?month=${$(".page-header").attr("month")}
      &year=${$(".page-header").attr("year")}`,
    dataType: "JSON",
    success: function(data) {
      let context = document.getElementById("surveyChart").getContext("2d");
      let graphColorArray = [
        "#2ecc71",
        "#3498db",
        "#95a5a6",
        "#9b59b6",
        "#f1c40f",
        "#e74c3c",
        "#34495e"
      ];
      let myChart = new Chart(context, {
        type: "pie",
        data: {
          labels: data.item_names,
          datasets: [
            {
              data: data.costs,
              backgroundColor: graphColorArray,
              pointBackgroundColor: "#ffffff"
            }
          ]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false
        }
      });
    }
  });
}
