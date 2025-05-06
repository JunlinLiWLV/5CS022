async function fetchData(){

    try{
        const response = await fetch("https://mi-linux.wlv.ac.uk/~2336879/5CS024/get_users.php")
        if(!response.ok){
            throw new Error("Failed to fetch data");
        }
        const userData = await response.json();
        createTable(userData);
    } catch(error){
        console.error(error);
        document.getElementById('users-container').innerHTML = '<p>There was an error fetching data from the server.</p>';
    }
}

function createTable(userData){
    const tableContainer = document.getElementById('users-container');

    const table = document.createElement('table');
    const thead = document.createElement('thead');
    const tbody = document.createElement('tbody');
    const headers = Object.keys(userData[0]);

    const headerRow = document.createElement('tr');
    headers.forEach(header => {
        const th = document.createElement('th');
        th.textContent = header;
        headerRow.appendChild(th);
    });
    thead.appendChild(headerRow);
    table.appendChild(thead);

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

fetchData();