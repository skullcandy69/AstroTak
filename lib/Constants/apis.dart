const baseUrl = "https://staging-api.astrotak.com/api";

const getQuestions = baseUrl + "/question/category/all";

const getRelative = baseUrl + "/relative/all";

const getLocations = baseUrl + "/location/place?inputPlace=";

const addRelative = baseUrl + "/relative";

const updateRelative = baseUrl + "/relative/update/"; //{uuid}

const deleteRelative = baseUrl + "/relative/delete/"; //{uuid}

const token =
    "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI4ODA5NzY1MTkxIiwiUm9sZXMiOltdLCJleHAiOjE2NzY0NjE0NzEsImlhdCI6MTY0NDkyNTQ3MX0.EVAhZLNeuKd7e7BstsGW5lYEtggbSfLD_aKqGFLpidgL7UHZTBues0MUQR8sqMD1267V4Y_VheBHpxwKWKA3lQ";
