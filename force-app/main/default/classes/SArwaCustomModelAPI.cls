public class SArwaCustomModelAPI {
    @AuraEnabled(cacheable=true)
    public static String createGeneration(String prompt) {
        // Create generations request
        aiplatform.ModelsAPI.createGenerations_Request request = new aiplatform.ModelsAPI.createGenerations_Request();
        // Specify model
        //request.modelName = 'sfdc_ai__DefaultOpenAIGPT4OmniMini';
        request.modelName = System.Label.SA_CustomAgentModel;
        // Create request body
        aiplatform.ModelsAPI_GenerationRequest body = new aiplatform.ModelsAPI_GenerationRequest();
        request.body = body;
        // Add prompt to body
        body.prompt = prompt;
        String modelsApiResponse = '';
        try {
            // Make request
            aiplatform.ModelsAPI modelsAPI = new aiplatform.ModelsAPI();
            if(Test.isRunningTest()){
                modelsApiResponse = 'This is a generated text of 333224444 is ***** out.';
            } else {
            aiplatform.ModelsAPI.createGenerations_Response response = modelsAPI.createGenerations(request);
            modelsApiResponse = response.Code200.generation.generatedText;
            }
        // Handle error
        } catch(aiplatform.ModelsAPI.createGenerations_ResponseException e) {
            //System.debug('Response code: ' + e.responseCode);
            //System.debug('The following exception occurred: ' + e);
            // Add error to the return value
            modelsApiResponse = 'Unable to get a valid response. Error code: ' + e.responseCode;
        }
        // Return response
        return modelsApiResponse;
    }
}