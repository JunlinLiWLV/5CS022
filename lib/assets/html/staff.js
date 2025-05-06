async function fetchData(){

    try{
        const response = await fetch("https://mi-linux.wlv.ac.uk/~2336879/5CS024/qr_stats.php")
        if(!response.ok){
            throw new Error("Failed to fetch data");
        }
        const courseData = await response.json();
        renderPie(courseData);
    } catch(error){
        console.error(error);
        document.getElementById('pie-container').innerHTML = '<p>There was an error fetching data from the server.</p>';
    }
}

function createPieChart(course) {
    const numScan = parseInt(course.NumScan)
    const interested = parseInt(course.Interested)
    const notInterested = numScan - interested;

    const pieChart = document.createElement('div');
    pieChart.classList.add('pie');

    const canvas = document.createElement('canvas');
    const canvasId = `pieChart_${course.ID}`;
    canvas.id = canvasId;

    pieChart.appendChild(canvas);

    const textArea = document.createElement('p');
    textArea.classList.add('pie-description');
    textArea.textContent = `Total number of attendees: ${numScan}`;

    pieChart.appendChild(textArea);

    document.getElementById('pie-container').appendChild(pieChart);

    new Chart(document.getElementById(canvasId), {
        type: 'pie',
        data: {
            labels: ['Interested', 'Not Interested'],
            datasets: [{
                data: [interested, notInterested],
                backgroundColor: [
                    'rgb(49,178,211)',
                    'rgb(231,73,87)',
                ],
                borderColor: [
                    'rgb(25,124,147)',
                    'rgb(119,14,23)',
                ],
                borderWidth: 1,
            }]
        },
        options: {
          responsive: true,
          plugins: {
              title: {
                  display: true,
                  text: `${course.CourseName} (${course.CourseCode})`,
                  font: {
                      size: 16,
                      weight: 'bold',
                      family: 'Roboto, sans-serif',
                  }

              },
              legend: {
                  position: 'right',
                  labels: {
                      formatter: '{value} <br/>{value}',
                  }

              },
          }
        }
    }
    );


}

function renderPie(courseData){
    if (courseData && Array.isArray(courseData)){
        courseData.forEach(item => {
            createPieChart(item);
        })
    } else {
        console.error("Data is improperly formatted")
        document.getElementById('pie-container').innerHTML = '<p>There was an error fetching data.</p>';
    }
}

fetchData();