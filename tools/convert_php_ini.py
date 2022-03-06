# Converty environment variables to PHP.ini

fp = open('./fix.csv','r')

lines = fp.readlines()

phpdict = {'PHP':[]}

for index, line in enumerate(lines):
    topics = line.strip().split('.')
    if len(topics)>=2:
        if topics[0] == 'PHP':
            if len(topics) == 2:
                print('adding to PHP')
                topicstr = newtopic 
                for remainingTopics in topics[1:]:
                    topicstr += "." + remainingTopics

                phpdict['PHP'].append(topicstr)
            else:
                newtopic=topics[1]
                print ('newtopic: ', newtopic)

                topicstr = newtopic 
                topicstr = newtopic 
                for remainingTopics in topics[2:]:
                    topicstr += "." + remainingTopics

                if not (newtopic in phpdict):
                    phpdict[newtopic] = [topicstr]
                else:
                    print('adding to new topic')
                    phpdict[newtopic].append(topicstr)
#print(phpdict['mongo'])
fp.close()

for key in phpdict:
    print(key, '->', phpdict[key]) 
fpo = open('./php.ini','w')

for key in phpdict:
    if key != 'PHP':
        wstring = "[" + key + "]"
        fpo.write(wstring+"\n")
        fpo.write("\n")
    for keyvalues in phpdict[key]:
        fpo.write(keyvalues+"\n")
    fpo.write("\n")
    
fpo.close()
