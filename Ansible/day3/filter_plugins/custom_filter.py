import json

class FilterModule(object):
    '''
    Custom filters are loaded by
    FilterModule objects
    '''
    
    def filters(self):
        return {
            'fnd': self.fnd,
        }

    def fnd(self, accounts):
        for line in accounts:
            if line['name'] == 'Identity':
                print(line['id'])
                return line['id']
        return "Nothing"

