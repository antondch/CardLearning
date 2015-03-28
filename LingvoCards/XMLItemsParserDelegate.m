//
//  XMLItemsParserDelegate.m
//  LingvoCards
//
//  Created by jessie on 28.03.15.
//  Copyright (c) 2015 DCH. All rights reserved.
//

#import "XMLItemsParserDelegate.h"

@implementation XMLItemsParserDelegate
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    m_done = NO;
    m_items = [[NSMutableArray alloc] init];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    m_done = YES;
    if(self.doneParse){
        self.doneParse();
    }
}

-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    m_done = YES;
    m_error = parseError;
}

-(void) parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    m_done = YES;
    m_error = validationError;
}
// встретили новый элемент
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    m_isItem = [[elementName lowercaseString] isEqualToString:@"row"];
    m_isItemProp = [[elementName lowercaseString] isEqualToString:@"data"];
    if(m_isItemProp){
        m_prop = [[NSMutableString alloc]init];
    }else{
        if (m_isItem ) {
            m_item = [[NSMutableArray alloc] init];
        }
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    m_isItem = [[elementName lowercaseString] isEqualToString:@"row"];
    m_isItemProp = [[elementName lowercaseString] isEqualToString:@"data"];
    if(m_isItemProp){
        [m_item addObject:m_prop];
    }
    if ( m_isItem ) {
        [m_items addObject:m_item];
    }
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (m_isItemProp) {
        NSString* resS = [string stringByTrimmingCharactersInSet:[NSCharacterSet
                                                             whitespaceCharacterSet]];
        [m_prop appendString:resS];
    }

}
-(NSArray*)items{
    return m_items;
}
@end
