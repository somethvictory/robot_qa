const fetch_api = (url, method, body, successCallback, failureCallback) => {
  fetch(url, {
    method: method,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(body)
  })
  .then(response => response.json()).then(successCallback).catch(failureCallback);

}
export default fetch_api;
