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

    #Create ArrayList to store split strings. ArrayList necessary Arrays are fixed size.

    $SplitMedals = @()

    #Split string on '.' into key value pairs, where country is key and medal is value, place into arraylist.

    For ($i = 0 ; $i -lt $Medals.length; $i++) {
        For ($ii = 0 ; $ii -lt $Medals[$i]['podium'].length; $ii++) {
            [System.Collections.ArrayList]$SplitMedals += @($Medals[$i]['podium'][$ii].Split(".")[1] , $Medals[$i]['podium'][$ii].Split(".")[0])         
        }     
    }

    #Iterate over $Splitmedals and change number strings into ints
    #Also change medal number into its score eg. 1(Gold) becomes 3 as it is worth 3 points.

    For ($i = 0 ; $i -lt $SplitMedals.count; $i++) {
        
        If ( $SplitMedals[$i] -eq '1') {
            $SplitMedals[$i] = 3
        }
        elseif ( $SplitMedals[$i] -eq '2') {
            $SplitMedals[$i] = 2
        }
        elseif ( $SplitMedals[$i] -eq '3') {
            $SplitMedals[$i] = 1
        }
    }
   
    #Iterate over $Splitmedals array and mark duplicate keys, while adding their values and then marking.
    #Duplicates are marked rather than removed instantly in order to iterate smoothly as I am iterating with +2
    #Duplicates to be removed in order to prep data for a HashTable later on.
    For ($i = 0 ; $i -lt $SplitMedals.count; $i = $i + 2) {
        For ($j = $i + 2 ; $j -lt $SplitMedals.count; $j = $j + 2) {
            if ($SplitMedals[$i] -eq $SplitMedals[$j]) {
                $SplitMedals[$i + 1] += $SplitMedals[$j + 1] 
                $SplitMedals[$j] = 'remove'
                $SplitMedals[$j + 1] = 'remove'
            }
        }
    }

    #Remove the values from the array that have been marked for deletion
    while ($SplitMedals -contains "remove") {
        $SplitMedals.Remove("remove")
        #To remove a quirk bought about in one instance, of an [$i] == [$j] because they were both marked and then +=ing the mark.
        $SplitMedals.Remove("removeremove")
    }
 

    #Create a HashTable for the final medal results
    $MedalTable = @{}

    #Fill HashTable with 
    for ( $i = 0; $i -lt $SplitMedals.count; $i += 2 ) {
        $MedalTable.Add($SplitMedals[$i], $SplitMedals[$i + 1])
    }

    #return final medal table, sorted by highest score first
    return $MedalTable.GetEnumerator() | sort value -descending 
}