#for write-output purposes

$MedalResults = @(
    @{
        'sport' = 'cycling'
        'podium' = @('1.China', '2.Germany', '3.ROC')
    }
    @{
        'sport' = 'fencing'
        'podium' = @('1.ROC', '2.France', '3.Italy')
    }
    @{
        'sport' = 'high jump'
        'podium' = @('1.Italy', '1.Qatar', '3.Belarus')
    }
    @{
        'sport' = 'swimming'
        'podium' = @('1.USA', '2.France', '3.Brazil')
    }
)

function Build-MedalTable {
    param
    (
        [Parameter(Mandatory)]
        [array]
        $Medals
    )

    # Add your code here
    # Create a medal table based on the provided result list
    # First place gives 3 points, second place 2 points and third place 1 point

    $SplitMedals = @()

    #Split string on . into key value pairs

    For($i = 0 ; $i -lt $Medals.length; $i++) {
        For($ii = 0 ; $ii -lt $Medals[$i]['podium'].length; $ii++) {
            [System.Collections.ArrayList]$SplitMedals += @($Medals[$i]['podium'][$ii].Split(".")[1] , $Medals[$i]['podium'][$ii].Split(".")[0])
           
            
        }

        
    }
   # Write-output $SplitMedals
        
    #write-output ''

    For($i = 0 ; $i -lt $SplitMedals.count; $i++) {

        
        If( $SplitMedals[$i] -eq '1') {
            $SplitMedals[$i] = 3
        }
        elseif( $SplitMedals[$i] -eq '2') {
            $SplitMedals[$i]  = 2
        }
        elseif ( $SplitMedals[$i]  -eq '3') {
            $SplitMedals[$i]  = 1
        }
    }
   # Write-output $SplitMedals

    For($i = 0 ; $i -lt $SplitMedals.count; $i = $i + 2) {
        For($j = $i + 2 ; $j -lt $SplitMedals.count; $j = $j + 2) {
        if($SplitMedals[$i] -eq $SplitMedals[$j]){
           $SplitMedals[$i+1] += $SplitMedals[$j+1] 
           $SplitMedals[$j] = 'remove'
           $SplitMedals[$j+1] = 'remove'
        }

        }
    }

  #  Write-output $SplitMedals
   # Write-output ''

    while ($SplitMedals -contains "remove") {
        $SplitMedals.Remove("remove")
        $SplitMedals.Remove("removeremove")
    }
   # Write-output $SplitMedals
  #  Write-output ''


    $MedalTable = new-object System.Collections.Hashtable
    for ( $i = 0; $i -lt $SplitMedals.count; $i += 2 ) {
    $MedalTable.Add($SplitMedals[$i],$SplitMedals[$i+1]);
}

  #  Write-output $MedalTable
 #   Write-output ''

    #write-output $MedalTable
    return $MedalTable.GetEnumerator() | Sort-Object value -descending

   
     
    
    
    #write-output $Medals
    
    #CommandNotFoundException: The term 'Build-MedalTable' is not recognized as the name of a cmdlet, function, script file, or operable program. Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
    #Error seems to be outside the 'code goes here' part of the file so not sure what I actually need to do to fix this
    #Also I'm presumably not supposed to edit the medals.tests.ps1 file?
}

Import-Module .\medals.ps1

#For testing purposes
Build-MedalTable $MedalResults