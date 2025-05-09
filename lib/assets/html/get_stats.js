async function fetchData(){
    //try fetching data from the PHP script on the server
    try{
        const response = await fetch("https://mi-linux.wlv.ac.uk/~2336879/5CS024/qr_stats.php")
        if(!response.ok){
            throw new Error("Failed to fetch data");
        }
        const courseData = await response.json();
        renderPie(courseData);
    } catch(error){
        //if there's an error display a message where pie charts should load
        console.error(error);
        document.getElementById('pie-container').innerHTML = '<p>There was an error fetching data from the server.</p>';
    }
}

function createPieChart(course) {
    //get the variables needed to create the pies
    const numScan = parseInt(course.NumScan)
    const interested = parseInt(course.Interested)
    const notInterested = numScan - interested;

    const pieChart = document.createElement('div');
    pieChart.classList.add('pie');

    const canvas = document.createElement('canvas');
    const canvasId = `pieChart_${course.ID}`;
    canvas.id = canvasId;

    pieChart.appendChild(canvas);

    //under each pie chart show the total number of attendees for each course workshop
    const textArea = document.createElement('p');
    textArea.classList.add('pie-description');
    textArea.textContent = `Total number of attendees: ${numScan}`;

    pieChart.appendChild(textArea);

    document.getElementById('pie-container').appendChild(pieChart);

    //create the pie chart
    new Chart(document.getElementById(canvasId), {
        type: 'pie',
        data: {
            //define the data being used and the colours for each section of the pie
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

//for each one of the courses, create a pie chart for them.
function renderPie(courseData){
    if (courseData && Array.isArray(courseData)){
        courseData.forEach(item => {
            createPieChart(item);
        })
    } else {
        //if the data from the server is not JSON format, display error message
        console.error("Data is improperly formatted")
        document.getElementById('pie-container').innerHTML = '<p>There was an error fetching data.</p>';
    }
}

//when the page is loaded, attempt to fetch data from the server
fetchData();
