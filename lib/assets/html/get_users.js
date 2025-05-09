async function fetchData(){

    //try fetching data from the PHP script on the server, then decode the JSON
    try{
        const response = await fetch("https://mi-linux.wlv.ac.uk/~2336879/5CS024/get_users.php")
        if(!response.ok){
            throw new Error("Failed to fetch data");
        }
        const userData = await response.json();
        createTable(userData);
    } catch(error){
        //if there's an error, add an error message to the HTML
        console.error(error);
        document.getElementById('users-container').innerHTML = '<p>There was an error fetching data from the server.</p>';
    }
}

//loops through the data and creates a row in the table for each one of the users
//the row is then populated with user information from the DB
function createTable(userData){
    const tableContainer = document.getElementById('users-container');

    const table = document.createElement('table');
    const thead = document.createElement('thead');
    const tbody = document.createElement('tbody');
    const headers = Object.keys(userData[0]);

    //add headers to the table
    const headerRow = document.createElement('tr');
    headers.forEach(header => {
        const th = document.createElement('th');
        th.textContent = header;
        headerRow.appendChild(th);
    });
    thead.appendChild(headerRow);
    table.appendChild(thead);

    //add each one of the users to the table
    userData.forEach((user) => {
        const row = document.createElement('tr');
        headers.forEach(header => {
            const cell = document.createElement('td');
            cell.textContent = user[header];
            row.appendChild(cell);
        })
        tbody.appendChild(row);
    })
    table.appendChild(tbody);

    tableContainer.appendChild(table);
}

//when the page is loaded, run the fetchData function
fetchData();
