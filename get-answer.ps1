## Get-Answer.msh 
## Use Encarta's Instant Answers to answer your question. 

param([string] $question = $(throw "Please ask a question.")) 

function Main 
{ 
   # Load the System.Web.HttpUtility DLL, to let us URLEncode 
   [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Web") 

   ## Get the web page into a single string 
   $encoded = [System.Web.HttpUtility]::UrlEncode($question) 
   $text = get-webpage "http://search.msn.com/encarta/results.aspx?q=$encoded" 

   ## Get the answer with annotations 
   $startIndex = $text.IndexOf('<div id="results">') 
   $endIndex = $text.IndexOf('</div></div><h2>Results</h2>') 

   ## If we found a result, then filter the result 
   if(($startIndex -ge 0) -and ($endIndex -ge 0)) 
   { 
      $partialText = $text.Substring($startIndex, $endIndex - $startIndex) 
    
      ## Very fragile, voodoo screen scraping here 
      $regex = "<\s*a\s*[^>]*?href\s*=\s*[`"']*[^`"'>]+[^>]*>.*?</a>" 
      $partialText = [Regex]::Replace("$partialText", $regex, "") 
      $partialText = $partialText -replace "</div>", "`n" 
      $partialText = $partialText -replace "</span>", "`n" 
      $partialText = clean-html $partialText 
      $partialText = $partialText -replace "`n`n", "`n" 
     
      $partialText.TrimEnd() 
   } 
   else 
   { 
      "No answer found." 
   } 
} 


## Get a web page 
function Get-WebPage ($url=$(throw "need to specify the URL to fetch")) 
{ 
    # canonicalize the url 
    if ($url -notmatch "^[a-z]+://") { $url = "http://$url" } 
     
    $wc = new-object System.Net.WebClient  
    $wc.Headers.Add("user-agent", $userAgent) 
    $wc.DownloadString($url) 
} 

## Clean HTML from a text chunk 
function Clean-Html ($htmlInput) 
{ 
    [Regex]::Replace($htmlInput, "<[^>]*>", "") 
} 

. Main