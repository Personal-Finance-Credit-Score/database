# Personal Finance - Database Structure

## Setup
1. Open a command prompt or terminal window.
2. Navigate to the directory where you saved the .sql file using the cd command.
3. Execute the script using the psql command. Replace your_database_name with the name of your PostgreSQL database:

`<!-- COPY -->`
```psql -d your_database_name -f database_setup.sql```

<p>
    <button class="copy-button" onclick="copyToClipboard('code-block')">Copy</button>
</p>

<pre>
<code id="code-block">
psql -d your_database_name -f database_setup.sql
</code>
</pre>

<script>
function copyToClipboard(elementId) {
    const codeBlock = document.getElementById(elementId);
    const textArea = document.createElement('textarea');
    textArea.value = codeBlock.textContent;
    document.body.appendChild(textArea);
    textArea.select();
    document.execCommand('copy');
    document.body.removeChild(textArea);
}
</script>