---
layout: post
title: "Sending POST data int Android"
categories: Android
---

###Reference

[Sending POST data in Android](http://stackoverflow.com/questions/2938502/sending-post-data-in-android)

###Example

> Http Client from Apache Commons is the way to go. It is already included in android. Here's a simple example of how to do HTTP Post using it.

```Java
new AsyncTask<Void,Void,String>()
        {
            @Override
            protected String doInBackground(Void... params) {
                Log.d(TAG,"doInBackground url:"+url);

                HttpClient client = new DefaultHttpClient();
                Log.d(TAG,"HttpClient constructed:");

                HttpPost httpPost = new HttpPost(url);
                Log.d(TAG,"HttpPost constructed:");

                ArrayList<NameValuePair> valuePairs = new ArrayList<NameValuePair>();
                Log.d(TAG,"valuePairs constructed:");
                //!!!

                for(int i=0 ; i<kvs.length;i=i+2)
                {
                    Log.d(TAG,"KVS Params:"+kvs[i]+kvs[i+1]);
                    NameValuePair valuePair = new BasicNameValuePair(kvs[i],kvs[i+1]);
                    valuePairs.add(valuePair);
                }
                Log.d(TAG,"valuePairs assignment:");

                try {

                    HttpEntity httpEntity = new UrlEncodedFormEntity(valuePairs);
                    Log.d(TAG,"HttpEntity constructed:");

                    httpPost.setEntity(httpEntity);
                    Log.d(TAG, "httpPost.setEntity(httpEntity);");

                    try {

                        //!!!internet permission
                        HttpResponse httpResponse  = client.execute(httpPost);

                        InputStream inputStream = httpResponse.getEntity().getContent();

                        InputStreamReader inputStreamReader = new InputStreamReader(inputStream);

                        BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

                        StringBuilder stringBuilder = new StringBuilder();

                        String bufferedStrChunk = null;

                        while((bufferedStrChunk = bufferedReader.readLine()) != null){
                            stringBuilder.append(bufferedStrChunk);
                        }

                        Log.d(TAG,"httpResponse reult:"+stringBuilder.toString());

                        return stringBuilder.toString();

                    } catch (IOException e) {
                        e.printStackTrace();
                    }

                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }

                return null;
            }

            @Override
            protected void onPostExecute(String result) {
                super.onPostExecute(result);

                Log.d(TAG,"onPostExecute result"+result);

                if(null==result)
                {
                    failureCallback.onFailure();
                    return;
                }

                successCallback.onSucccess(result);
            }
        }.execute();
```

