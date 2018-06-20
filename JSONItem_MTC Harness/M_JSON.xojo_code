#tag Module
Protected Module M_JSON
	#tag Method, Flags = &h21
		Private Sub AdvancePastWhiteSpace(mb As MemoryBlock, p As Ptr, ByRef bytePos As Integer)
		  #if not DebugBuild
		    #pragma BackgroundTasks kAllowBackgroudTasks
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  dim mbSize as integer = mb.Size
		  while bytePos < mbSize
		    select case p.Byte( bytePos )
		    case kTab, kLinefeed, kReturn, kSpace
		      bytePos = bytePos + 1
		    case else
		      return
		    end select
		  wend
		  
		  raise new JSONException( "Unexpected end of data at", 2, bytePos )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EncodeArray(value As Variant, toArray() As String, level As Integer, ByRef inBuffer As MemoryBlock, ByRef outBuffer As MemoryBlock)
		  #if not DebugBuild
		    #pragma BackgroundTasks kAllowBackgroudTasks
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  dim thisIndent as string
		  dim nextIndent as string
		  const kComma as string = ","
		  if level <> -1 then
		    ExpandIndentArr level + 1
		    thisIndent = IndentArr( level )
		    nextIndent = IndentArr( level + 1 )
		  end if
		  
		  dim isEmpty as boolean = true
		  
		  toArray.Append "["
		  
		  select case Introspection.GetType( value ).Name
		  case "Variant()"
		    dim arr() as variant = value
		    if arr.Ubound <> -1 then
		      isEmpty = false
		    end if
		    
		    for i as integer = 0 to arr.Ubound
		      if level <> -1 then
		        toArray.Append EndOfLine
		        toArray.Append nextIndent
		      end if
		      EncodeValue arr( i ), toArray, level + 1, inBuffer, outBuffer
		      if i < arr.Ubound then
		        toArray.Append kComma
		      end if
		    next
		    
		  case "Auto()"
		    dim arr() as auto = value
		    if arr.Ubound <> -1 then
		      isEmpty = false
		    end if
		    
		    for i as integer = 0 to arr.Ubound
		      if level <> -1 then
		        toArray.Append EndOfLine
		        toArray.Append nextIndent
		      end if
		      dim item as variant = arr( i )
		      EncodeValue item, toArray, level + 1, inBuffer, outBuffer
		      if i < arr.Ubound then
		        toArray.Append kComma
		      end if
		    next
		    
		  case "String()"
		    dim arr() as string = value
		    if arr.Ubound <> -1 then
		      isEmpty = false
		    end if
		    
		    for i as integer = 0 to arr.Ubound
		      if level <> -1 then
		        toArray.Append EndOfLine
		        toArray.Append nextIndent
		      end if
		      dim item as string = arr( i )
		      EncodeString item, toArray, inBuffer, outBuffer
		      if i < arr.Ubound then
		        toArray.Append kComma
		      end if
		    next
		    
		  case "Text()"
		    dim arr() as text = value
		    if arr.Ubound <> -1 then
		      isEmpty = false
		    end if
		    
		    for i as integer = 0 to arr.Ubound
		      if level <> -1 then
		        toArray.Append EndOfLine
		        toArray.Append nextIndent
		      end if
		      dim item as string = arr( i )
		      EncodeString item, toArray, inBuffer, outBuffer
		      if i < arr.Ubound then
		        toArray.Append kComma
		      end if
		    next
		    
		  case "Double()"
		    dim arr() as double = value
		    if arr.Ubound <> -1 then
		      isEmpty = false
		    end if
		    
		    for i as integer = 0 to arr.Ubound
		      if level <> -1 then
		        toArray.Append EndOfLine
		        toArray.Append nextIndent
		      end if
		      dim item as double = arr( i )
		      EncodeValue item, toArray, level + 1, inBuffer, outBuffer
		      if i < arr.Ubound then
		        toArray.Append kComma
		      end if
		    next
		    
		  case "Single()"
		    dim arr() as single = value
		    if arr.Ubound <> -1 then
		      isEmpty = false
		    end if
		    
		    for i as integer = 0 to arr.Ubound
		      if level <> -1 then
		        toArray.Append EndOfLine
		        toArray.Append nextIndent
		      end if
		      dim item as single = arr( i )
		      EncodeValue item, toArray, level + 1, inBuffer, outBuffer
		      if i < arr.Ubound then
		        toArray.Append kComma
		      end if
		    next
		    
		  case "Int32()"
		    dim arr() as Int32 = value
		    if arr.Ubound <> -1 then
		      isEmpty = false
		    end if
		    
		    for i as integer = 0 to arr.Ubound
		      if level <> -1 then
		        toArray.Append EndOfLine
		        toArray.Append nextIndent
		      end if
		      dim item as Int32 = arr( i )
		      EncodeValue item, toArray, level + 1, inBuffer, outBuffer
		      if i < arr.Ubound then
		        toArray.Append kComma
		      end if
		    next
		    
		  case "Int64()"
		    dim arr() as Int64 = value
		    if arr.Ubound <> -1 then
		      isEmpty = false
		    end if
		    
		    for i as integer = 0 to arr.Ubound
		      if level <> -1 then
		        toArray.Append EndOfLine
		        toArray.Append nextIndent
		      end if
		      dim item as Int64 = arr( i )
		      EncodeValue item, toArray, level + 1, inBuffer, outBuffer
		      if i < arr.Ubound then
		        toArray.Append kComma
		      end if
		    next
		    
		  case "Integer()"
		    dim arr() as Integer = value
		    if arr.Ubound <> -1 then
		      isEmpty = false
		    end if
		    
		    for i as integer = 0 to arr.Ubound
		      if level <> -1 then
		        toArray.Append EndOfLine
		        toArray.Append nextIndent
		      end if
		      dim item as Integer = arr( i )
		      EncodeValue item, toArray, level + 1, inBuffer, outBuffer
		      if i < arr.Ubound then
		        toArray.Append kComma
		      end if
		    next
		    
		  case "Boolean()"
		    dim arr() as boolean = value
		    if arr.Ubound <> -1 then
		      isEmpty = false
		    end if
		    
		    for i as integer = 0 to arr.Ubound
		      if level <> -1 then
		        toArray.Append EndOfLine
		        toArray.Append nextIndent
		      end if
		      dim item as boolean = arr( i )
		      EncodeValue item, toArray, level + 1, inBuffer, outBuffer
		      if i < arr.Ubound then
		        toArray.Append kComma
		      end if
		    next
		    
		  case else
		    //
		    // Objects?
		    //
		    dim arr() as object = value
		    if arr.Ubound <> -1 then
		      isEmpty = false
		    end if
		    
		    for i as integer = 0 to arr.Ubound
		      if level <> -1 then
		        toArray.Append EndOfLine
		        toArray.Append nextIndent
		      end if
		      dim item as object = arr( i )
		      EncodeValue item, toArray, level + 1, inBuffer, outBuffer
		      if i < arr.Ubound then
		        toArray.Append kComma
		      end if
		    next
		    
		  end select
		  
		  if level <> -1 and not isEmpty then
		    toArray.Append EndOfLine
		    toArray.Append thisIndent
		  end if
		  
		  toArray.Append "]"
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EncodeDictionary(dict As Dictionary, toArray() As String, level As Integer, ByRef inBuffer As MemoryBlock, ByRef outBuffer As MemoryBlock)
		  #if not DebugBuild
		    #pragma BackgroundTasks kAllowBackgroudTasks
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  dim keys() as variant = dict.Keys
		  dim values() as variant = dict.Values
		  
		  dim thisIndent as string
		  dim nextIndent as string
		  const kComma as string = ","
		  dim colon as string = ":"
		  if level <> -1 then
		    ExpandIndentArr( level + 1 )
		    thisIndent = IndentArr( level )
		    nextIndent = IndentArr( level + 1 )
		    colon = " : "
		  end if
		  
		  toArray.Append "{"
		  if keys.Ubound = -1 then
		    toArray.Append "}"
		    return
		  end if
		  
		  for i as integer = 0 to keys.Ubound
		    dim key as string = keys( i ).StringValue
		    dim value as variant = values( i )
		    
		    if level <> -1 then
		      toArray.Append EndOfLine
		      toArray.Append nextIndent
		    end if
		    
		    EncodeString key, toArray, inBuffer, outBuffer
		    toArray.Append colon
		    EncodeValue value, toArray, level + 1, inBuffer, outBuffer
		    if i < keys.Ubound then
		      toArray.Append kComma
		    end if
		  next
		  
		  if level <> -1 then
		    toArray.Append EndOfLine
		    toArray.Append thisIndent
		  end if
		  toArray.Append "}"
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EncodeString(s As String, toArray() As String, ByRef inBuffer As MemoryBlock, ByRef outBuffer As MemoryBlock)
		  #if not DebugBuild
		    #pragma BackgroundTasks kAllowBackgroudTasks
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  const kSlash as integer = 47
		  const kA as integer = 65
		  const kB as integer = 98
		  const kF as integer = 102
		  const kN as integer = 110
		  const kR as integer = 114
		  const kT as integer = 116
		  const kU as integer = 117
		  
		  if s = "" then
		    toArray.Append """"""
		    return
		  end if
		  
		  if s.Encoding is nil then
		    if Encodings.UTF8.IsValidData( s ) then
		      s = s.DefineEncoding( Encodings.UTF8 )
		    else
		      s = s.DefineEncoding( Encodings.SystemDefault )
		      s = s.ConvertEncoding( Encodings.UTF8 )
		    end if
		    
		  elseif s.Encoding <> Encodings.UTF8 then
		    s = s.ConvertEncoding( Encodings.UTF8 )
		  end if
		  
		  dim sLen as integer = s.LenB
		  if inBuffer.Size < sLen then
		    inBuffer = new MemoryBlock( sLen * 2 )
		  end if
		  
		  inBuffer.StringValue( 0, sLen ) = s
		  dim pIn as ptr = inBuffer
		  
		  dim outSize as integer = sLen * 6 + 2
		  if outBuffer.Size < outSize then
		    outBuffer = new MemoryBlock( outSize * 2 )
		  end if
		  
		  dim pOut as ptr = outBuffer
		  
		  dim lastInByte as integer = sLen - 1
		  dim outIndex as integer = 0
		  for inIndex as integer = 0 to lastInByte
		    dim thisByte as integer = pIn.Byte( inIndex )
		    
		    select case thisByte
		    case 8 // vertical tab
		      pOut.Byte( outIndex ) = kBackslash
		      outIndex = outIndex + 1
		      pOut.Byte( outIndex ) = kB
		      outIndex = outIndex + 1
		      
		    case 9 // tab
		      pOut.Byte( outIndex ) = kBackslash
		      outIndex = outIndex + 1
		      pOut.Byte( outIndex ) = kT
		      outIndex = outIndex + 1
		      
		    case 10 // linefeed
		      pOut.Byte( outIndex ) = kBackslash
		      outIndex = outIndex + 1
		      pOut.Byte( outIndex ) = kN
		      outIndex = outIndex + 1
		      
		    case 12 // form feed
		      pOut.Byte( outIndex ) = kBackslash
		      outIndex = outIndex + 1
		      pOut.Byte( outIndex ) = kF
		      outIndex = outIndex + 1
		      
		    case 13 // return
		      pOut.Byte( outIndex ) = kBackslash
		      outIndex = outIndex + 1
		      pOut.Byte( outIndex ) = kR
		      outIndex = outIndex + 1
		      
		    case is < 16 // have to encode it
		      pOut.Byte( outIndex ) = kBackslash
		      outIndex = outIndex + 1
		      pOut.Byte( outIndex ) = kU
		      outIndex = outIndex + 1
		      outBuffer.StringValue( outIndex, 3 ) = "000"
		      outIndex = outIndex + 3
		      outBuffer.StringValue( outIndex, 1 ) = Hex( thisByte )
		      outIndex = outIndex + 1
		      
		    case is < 32 // have to encode it
		      pOut.Byte( outIndex ) = kBackslash
		      outIndex = outIndex + 1
		      pOut.Byte( outIndex ) = kU
		      outIndex = outIndex + 1
		      outBuffer.StringValue( outIndex, 2 ) = "00"
		      outIndex = outIndex + 2
		      outBuffer.StringValue( outIndex, 2 ) = Hex( thisByte )
		      outIndex = outIndex + 2
		      
		    case else
		      pOut.Byte( outIndex ) = thisByte
		      outIndex = outIndex + 1
		      
		    end select
		    
		  next
		  
		  toArray.Append """"
		  toArray.Append outBuffer.StringValue( 0, outIndex ).DefineEncoding( Encodings.UTF8 )
		  toArray.Append """"
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub EncodeValue(value As Variant, toArray() As String, level As Integer, ByRef inBuffer As MemoryBlock, ByRef outBuffer As MemoryBlock)
		  //
		  // We don't know if this is being called from a broader encoder so
		  // we only append the raw value here
		  //
		  
		  #if not DebugBuild
		    #pragma BackgroundTasks kAllowBackgroudTasks
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  if value.IsNull then
		    toArray.Append "nil"
		    return // EARLY RETURN
		  end if
		  
		  select case value.Type
		  case Variant.TypeBoolean
		    if value.BooleanValue then
		      toArray.Append "true"
		    else
		      toArray.Append "false"
		    end if
		    
		  case Variant.TypeInt32, Variant.TypeInt64, Variant.TypeInteger
		    toArray.Append value.StringValue
		    
		  case Variant.TypeDouble, Variant.TypeSingle
		    dim d as double = value.DoubleValue
		    dim dAbs as double = abs( d )
		    
		    if dAbs > ( 10.0 ^ 12.0 ) or dAbs < 0.00001 then
		      toArray.Append value.StringValue
		    else
		      toArray.Append format( d, "0.0########" )
		    end if
		    
		  case Variant.TypeString
		    EncodeString( value.StringValue, toArray, inBuffer, outBuffer )
		    
		  case Variant.TypeText
		    dim t as text = value.TextValue
		    dim s as string = t
		    EncodeString( s, toArray, inBuffer, outBuffer )
		    
		  case Variant.TypeDate
		    toArray.Append """"
		    toArray.Append value.DateValue.SQLDateTime
		    toArray.Append """"
		    
		  case else
		    if value.Type = Variant.TypeObject and value isa Dictionary then
		      EncodeDictionary( value, toArray, level, inBuffer, outBuffer )
		    elseif value.IsArray then
		      EncodeArray( value, toArray, level, inBuffer, outBuffer )
		    end if
		    
		  end select
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExpandIndentArr(targetUbound As Integer)
		  #if not DebugBuild
		    #pragma BackgroundTasks kAllowBackgroudTasks
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  if IndentArr.Ubound < targetUbound then
		    dim startingIndex as integer = IndentArr.Ubound + 1
		    if startingIndex = 0 then
		      startingIndex = 1
		    end if
		    
		    redim IndentArr( targetUbound )
		    for i as integer = startingIndex to targetUbound
		      IndentArr( i ) = IndentArr( i - 1 ) + kDefaultIndent
		    next
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GenerateJSON_MTC(json As Variant, prettyPrint As Boolean = False) As String
		  //
		  // Make sure we are starting with a Dictionary or array
		  //
		  
		  if json.IsNull then
		    return ""
		    
		  elseif json.Type = Variant.TypeObject and json isa Dictionary then
		    //
		    // Good
		    //
		    
		  elseif json.IsArray then
		    //
		    // Good
		    //
		    
		  else
		    raise new IllegalCastException
		    
		  end if
		  
		  if prettyPrint then
		    ExpandIndentArr( 256 )
		  end if
		  
		  dim arr() as string
		  dim level as integer = if( prettyPrint, 0, -1 )
		  dim inBuffer as new MemoryBlock( 100 )
		  dim outBuffer as new MemoryBlock( inBuffer.Size * 6 + 2 )
		  EncodeValue( json, arr, level, inBuffer, outBuffer )
		  
		  dim result as string = join( arr, "" )
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function HexValue(mb As MemoryBlock, p As Ptr, pos As Integer) As Integer
		  #if not DebugBuild
		    #pragma BackgroundTasks kAllowBackgroudTasks
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  const kZero as integer = 48
		  const kNine as integer = 57
		  const kBigA as integer = 65
		  const kBigF as integer = 70
		  const kLittleA as integer = 97
		  const kLittleF as integer = 102
		  
		  if ( pos + 4 ) >= mb.Size then
		    raise new JSONException( "Illegal value", 10, pos - 1 )
		  end if
		  
		  dim value as integer
		  
		  dim lastPos as integer = pos + 3
		  for i as integer = pos to lastPos
		    value = value * 16
		    
		    dim thisByte as integer = p.Byte( i )
		    
		    select case thisByte
		    case kZero to kNine
		      value = value + ( thisByte - kZero )
		      
		    case kBigA to kBigF
		      value = value + ( thisByte - kBigA + 10 )
		      
		    case kLittleA to kLittleF
		      value = value + ( thisByte - kLittleA + 10 )
		      
		    case else
		      raise new JSONException( "Illegal value", 10, pos - 1 )
		      
		    end select
		  next
		  
		  return value
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseArray(mb As MemoryBlock, p As Ptr, ByRef bytePos As Integer) As Variant()
		  #if not DebugBuild
		    #pragma BackgroundTasks kAllowBackgroudTasks
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  dim result() as variant
		  
		  dim expectingComma as boolean
		  dim foundComma as boolean
		  
		  dim mbSize as integer = mb.Size
		  
		  while bytePos < mbSize
		    AdvancePastWhiteSpace mb, p, bytePos
		    
		    dim thisByte as integer = p.Byte( bytePos )
		    
		    if thisByte = kComma then
		      if not expectingComma then
		        raise new JSONException( "Illegal value", 10, bytePos + 1 )
		      end if
		      
		      expectingComma = false
		      foundComma = true
		      bytePos = bytePos + 1
		      continue while
		    end if
		    
		    if thisByte = kCloseSquareBracket then
		      if foundComma then 
		        raise new JSONException( "Illegal value", 10, bytePos + 1 )
		      end if
		      
		      bytePos = bytePos + 1
		      
		      return result
		    end if
		    
		    if thisByte <> kComma and expectingComma then
		      raise new JSONException( "Illegal value", 10, bytePos + 1 )
		    end if
		    
		    foundComma = false
		    
		    dim value as variant = ParseValue( mb, p, bytePos )
		    result.Append value
		    
		    expectingComma = true
		    
		  wend
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParseJSON_MTC(json As String) As Variant
		  //
		  // Takes in JSON and returns either a Dictionary or Variant array
		  //
		  
		  if json = "" then
		    return nil
		  end if
		  
		  //
		  // First make sure we have a well encoded string.
		  // We'll try to be tolerant here.
		  //
		  if json.Encoding is nil then
		    dim threeNulls as string = ChrB( 0 ) + ChrB( 0 ) + ChrB( 0 )
		    dim oneNull as string = ChrB( 0 )
		    
		    dim firstFour as string = json.LeftB( 4 )
		    dim firstTwo as string = json.LeftB( 2 )
		    
		    if firstFour = ( "[" + threeNulls ) or firstFour = ( "{" + threeNulls ) then
		      json = json.DefineEncoding( Encodings.UTF32LE )
		    elseif firstFour = ( threeNulls + "[" ) or firstFour = ( threeNulls + "{" ) then
		      json = json.DefineEncoding( Encodings.UTF32BE )
		    elseif firstTwo = ( "[" + oneNull ) or firstTwo = ( "{" + oneNull ) then
		      json = json.DefineEncoding( Encodings.UTF16LE )
		    elseif firstTwo = ( oneNull + "[" ) or firstTwo = ( oneNull + "{" ) then
		      json = json.DefineEncoding( Encodings.UTF16BE )
		    elseif Encodings.UTF8.IsValidData( json ) then
		      json = json.DefineEncoding( Encodings.UTF8 )
		    else
		      //
		      // Best guess
		      //
		      json = json.DefineEncoding( Encodings.SystemDefault )
		    end if
		  end if
		  
		  json = json.ConvertEncoding( Encodings.UTF8 )
		  json = json.Trim
		  
		  if json = "" then
		    return nil
		  end if
		  
		  dim mbJSON as MemoryBlock = json
		  dim pJSON as Ptr = mbJSON
		  dim bytePos as integer = 0
		  
		  dim result as variant
		  dim thisByte as integer = pJSON.Byte( bytePos )
		  bytePos = bytePos + 1
		  
		  if thisByte = kSquareBracket then
		    result = ParseArray( mbJSON, pJSON, bytePos )
		  elseif thisByte = kCurlyBrace then
		    result = ParseObject( mbJSON, pJSON, bytePos )
		  else
		    raise new JSONException( "Illegal value", 10, 1 )
		  end if
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseNumber(mb As MemoryBlock, p As Ptr, ByRef bytePos As Integer) As Variant
		  //
		  // Will either return a double or an integer
		  //
		  
		  //
		  // Will attempt to be very tolerant
		  //
		  
		  #if not DebugBuild
		    #pragma BackgroundTasks kAllowBackgroudTasks
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  const kZero as integer = 48
		  const kNine as integer = 57
		  const kPlus as integer = 43
		  const kMinus as integer = 45
		  const kBigE as integer = 69
		  const kLittleE as integer = 101
		  
		  const kDot as integer = 46
		  
		  dim result as variant
		  
		  dim isDouble as boolean
		  dim foundDot as boolean
		  dim foundValue as boolean
		  dim isScientificNotation as boolean
		  dim foundE as boolean
		  
		  dim startPos as integer = bytePos
		  dim mbSize as integer = mb.Size
		  
		  do
		    if bytePos >= mbSize then
		      raise new JSONException( "Illegal value", 10, startPos )
		    end if
		    
		    dim thisByte as integer = p.Byte( bytePos )
		    
		    select case thisByte
		    case kTab, kReturn, kLinefeed, kSpace, kComma, kCloseCurlyBrace, kCloseSquareBracket
		      exit
		    end select
		    
		    select case thisByte
		    case kPlus, kMinus
		      if bytePos <> startPos and not foundE then
		        //
		        // This is illegal here
		        //
		        exit
		      else
		        foundE = false
		      end if
		      
		    case kZero to kNine
		      //
		      // A number
		      //
		      foundE = false
		      foundValue = true
		      
		    case kDot
		      if foundDot or isScientificNotation then
		        //
		        // Bad dot
		        //
		        raise new JSONException( "Illegal value", 10, startPos )
		        
		      else
		        foundDot = true
		        isDouble = true
		      end if
		      
		    case kBigE, kLittleE
		      if not foundValue or bytePos = startPos or isScientificNotation then
		        //
		        // Can't have two "e"s
		        //
		        raise new JSONException( "Illegal value", 10, startPos )
		        
		      else
		        isDouble = true
		        isScientificNotation = true
		        foundE = true
		      end if
		      
		    case else
		      //
		      // It's something else
		      //
		      exit
		      
		    end select
		    
		    bytePos = bytePos + 1
		  loop
		  
		  if not foundValue then
		    raise new JSONException( "Illegal value", 10, startPos )
		  end if
		  
		  //
		  // Get the value
		  //
		  dim byteLen as integer = bytePos - startPos
		  dim s as string = mb.StringValue( startPos, byteLen )
		  if isDouble then
		    dim d as double = s.Val
		    result = d
		  else
		    dim i as integer = s.Val
		    result = i
		  end if
		  
		  return result
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseObject(mb As MemoryBlock, p As Ptr, ByRef bytePos As Integer) As Dictionary
		  #if not DebugBuild
		    #pragma BackgroundTasks kAllowBackgroudTasks
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  const kColon as integer = 58
		  
		  dim result as new Dictionary
		  
		  dim key as string
		  dim value as variant
		  
		  dim expectingComma as boolean
		  dim expectingColon as boolean
		  dim expectingValue as boolean
		  dim foundComma as boolean
		  
		  dim mbSize as integer = mb.Size
		  
		  while bytePos < mbSize
		    AdvancePastWhiteSpace mb, p, bytePos
		    
		    dim thisByte as integer = p.Byte( bytePos )
		    
		    if thisByte = kComma then
		      if expectingComma then
		        expectingComma = false
		        foundComma = true
		        key = ""
		        value = nil
		        bytePos = bytePos + 1
		        continue while
		      else
		        raise new JSONException( "Unexpected character", 10, bytePos + 1 )
		      end if
		    end if
		    
		    if thisByte = kColon then
		      if expectingColon then
		        expectingColon = false
		        expectingValue = true
		        bytePos = bytePos + 1
		        continue while
		      else
		        raise new JSONException( "Unexpected character", 10, bytePos + 1 )
		      end if
		    end if
		    
		    if thisByte = kCloseCurlyBrace then
		      if foundComma or expectingColon or expectingValue then
		        raise new JSONException( "Illegal value", 10, bytePos + 1 )
		      else
		        //
		        // We're done
		        //
		        bytePos = bytePos + 1
		        return result
		      end if
		    end if
		    
		    foundComma = false
		    
		    if expectingComma and thisByte <> kComma then
		      raise new JSONException( "Missing comma", 6, bytePos + 1 )
		    elseif expectingColon and thisByte <> kColon then
		      raise new JSONException( "Missing colon", 6, bytePos + 1 )
		    end if
		    
		    if expectingValue then
		      expectingValue = false
		      expectingComma = true
		      value = ParseValue( mb, p, bytePos )
		      
		      result.Value( key ) = value
		      
		    elseif thisByte <> kQuote then
		      raise new JSONException( "Illegal value", 10, bytePos + 1 )
		      
		    else
		      
		      //
		      // It's a quote as expected for the key
		      //
		      expectingColon = true
		      bytePos = bytePos + 1
		      key = ParseString( mb, p, bytePos )
		      
		    end if
		  wend
		  
		  raise new JSONException( "Missing }", 6, bytePos + 1 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseString(mb As MemoryBlock, p As Ptr, ByRef bytePos As Integer) As String
		  //
		  // Prescan the MemoryBlock for a backslash
		  // If there aren't any, we don't need to do anything else
		  //
		  
		  #if not DebugBuild
		    #pragma BackgroundTasks kAllowBackgroudTasks
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  dim scanPos as integer = bytePos
		  dim mbSize as integer = mb.Size
		  do
		    if scanPos >= mbSize then
		      raise new JSONException( "Invalid string", 10, bytePos )
		    end if
		    
		    dim thisByte as integer = p.Byte( scanPos )
		    
		    select case thisByte
		    case kBackslash 
		      //
		      // We need the more extensive code
		      //
		      dim s as string
		      dim byteLen as integer = scanPos - bytePos
		      if byteLen <> 0 then
		        s = mb.StringValue( bytePos, byteLen )
		        bytePos = scanPos
		      end if
		      s = s + ParseStringWithBackslash( mb, p, bytePos )
		      s = s.DefineEncoding( Encodings.UTF8 )
		      return s
		      
		    case kQuote
		      //
		      // We found the end of the quote
		      //
		      dim s as string
		      dim byteLen as integer = scanPos - bytePos
		      if byteLen <> 0 then
		        s = mb.StringValue( bytePos, byteLen )
		        s = s.DefineEncoding( Encodings.UTF8 )
		      end if
		      
		      bytePos = scanPos + 1
		      return s
		      
		    end select
		    
		    scanPos = scanPos + 1
		  loop
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseStringWithBackslash(mb As MemoryBlock, p As Ptr, ByRef bytePos As Integer) As String
		  #if not DebugBuild
		    #pragma BackgroundTasks kAllowBackgroudTasks
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  const kSlash as integer = 47
		  const kB as integer = 98
		  const kF as integer = 102
		  const kN as integer = 110
		  const kR as integer = 114
		  const kT as integer = 116
		  const kU as integer = 117
		  
		  dim startPos as integer = bytePos
		  
		  dim builder() as string
		  dim inBackslash as boolean
		  dim expectingSurrogate as boolean
		  dim surrogateFirstHalf as integer
		  
		  dim mbSize as integer = mb.Size
		  while bytePos < mbSize
		    dim thisByte as integer = p.Byte( bytePos )
		    
		    if inBackslash then
		      inBackslash = false
		      
		      if expectingSurrogate and thisByte <> kU then
		        raise new JSONException( "Improperly formed JSON string", 0, bytePos + 1 )
		      end if
		      
		      select case thisByte
		      case kBackslash
		        builder.Append "\"
		        
		      case kSlash
		        builder.Append "/"
		        
		      case kQuote
		        builder.Append """"
		        
		      case kB
		        builder.Append &u08
		        
		      case kF
		        builder.Append &u0C
		        
		      case kN
		        builder.Append &u0A
		        
		      case kR
		        builder.Append &u0D
		        
		      case kT
		        builder.Append &u09
		        
		      case kU
		        dim codepoint as integer = HexValue( mb, p, bytePos + 1 )
		        bytePos = bytePos + 4
		        
		        if ( expectingSurrogate and ( codepoint < &hDC00 or codepoint > &hDFFF ) ) or _
		          ( not expectingSurrogate and codepoint >= &hDC00 and codepoint <= &hDFFF ) then
		          raise new JSONException( "Invalid codepoint", 10, bytePos - 1 )
		        end if
		        
		        if expectingSurrogate then
		          expectingSurrogate = false
		          
		          codepoint = Bitwise.ShiftLeft( surrogateFirstHalf - &hD800, 10, 20 ) + ( codepoint - &hDC00 ) + &h10000
		          builder.Append Chr( codepoint )
		          
		          
		        elseif codepoint < &hD800 or codepoint > &hDFFF then
		          builder.Append Chr( codepoint )
		          
		        else
		          surrogateFirstHalf = codepoint
		          expectingSurrogate = true
		          
		        end if
		        
		      case else
		        //
		        // If we were strict, we would...
		        //   raise new JSONException( "Invalid character after \", 10, bytePos + 1 )
		        //
		        // But we're not, so...
		        //
		        builder.Append ChrB( thisByte )
		        
		      end select
		      
		    elseif thisByte = kBackslash then
		      inBackslash = true
		      
		    elseif expectingSurrogate then
		      raise new JSONException( "Improperly formed JSON string", 0, bytePos + 1 )
		      
		    elseif thisByte = kQuote then
		      //
		      // We're done with this string
		      //
		      bytePos = bytePos + 1
		      dim s as string = join( builder, "" )
		      s = s.DefineEncoding( Encodings.UTF8 )
		      return s
		      
		    else
		      builder.Append ChrB( thisByte )
		      
		    end if
		    
		    bytePos = bytePos + 1
		    
		  wend
		  
		  //
		  // If we get here...
		  //
		  raise new JSONException( "Invalid string", 10, startPos + 1 )
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ParseValue(mb As MemoryBlock, p As Ptr, ByRef bytePos As Integer) As Variant
		  #if not DebugBuild
		    #pragma BackgroundTasks kAllowBackgroudTasks
		    #pragma BoundsChecking false
		    #pragma NilObjectChecking false
		    #pragma StackOverflowChecking false
		  #endif
		  
		  const kN as integer = 110
		  const kI as integer = 105
		  const kL as integer = 108
		  
		  const kF as integer = 102
		  const kA as integer = 97
		  const kS as integer = 115
		  const kE as integer = 101
		  
		  const kT as integer = 116
		  const kR as integer = 114
		  const kU as integer = 117
		  
		  AdvancePastWhiteSpace mb, p, bytePos
		  
		  select case p.Byte( bytePos )
		  case kSquareBracket
		    bytePos = bytePos + 1
		    return ParseArray( mb, p, bytePos )
		    
		  case kCurlyBrace 
		    bytePos = bytePos + 1
		    return ParseObject( mb, p, bytePos )
		    
		  case kN // Should be nil
		    if ( bytePos + 3 ) < mb.Size and p.Byte( bytePos + 1 ) = kI and p.Byte( bytePos + 2 ) = kL then
		      bytePos = bytePos + 3
		      return nil
		    end if
		    
		  case kT // Should be true
		    if ( bytePos + 4 ) < mb.Size and p.Byte( bytePos + 1 ) = kR and p.Byte( bytePos + 2 ) = kU and p.Byte( bytePos + 3 ) = kE then
		      bytePos = bytePos + 4
		      return true
		    end if
		    
		  case kF // Should be false
		    if ( bytePos + 5 ) < mb.Size and p.Byte( bytePos + 1 ) = kA and p.Byte( bytePos + 2 ) = kL and p.Byte( bytePos + 3 ) = kS _
		      and p.Byte( bytePos + 4 ) = kE then
		      bytePos = bytePos + 5
		      return false
		    end if
		    
		  case kQuote 
		    bytePos = bytePos + 1
		    return ParseString( mb, p, bytePos )
		    
		  case else
		    //
		    // Should be a number since everything else failed
		    //
		    return ParseNumber( mb, p, bytePos )
		    
		  end select
		  
		  
		  //
		  // If we get here
		  //
		  raise new JSONException( "Illegal value", 10, bytePos + 1 )
		  
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h21
		Private IndentArr() As String
	#tag EndProperty


	#tag Constant, Name = kAllowBackgroudTasks, Type = Boolean, Dynamic = False, Default = \"True", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kBackslash, Type = Double, Dynamic = False, Default = \"92", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kCloseCurlyBrace, Type = Double, Dynamic = False, Default = \"125", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kCloseSquareBracket, Type = Double, Dynamic = False, Default = \"93", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kComma, Type = Double, Dynamic = False, Default = \"44", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kCurlyBrace, Type = Double, Dynamic = False, Default = \"123", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kDefaultIndent, Type = String, Dynamic = False, Default = \"  ", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kLineFeed, Type = Double, Dynamic = False, Default = \"10", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kQuote, Type = Double, Dynamic = False, Default = \"34", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kReturn, Type = Double, Dynamic = False, Default = \"13", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kSpace, Type = Double, Dynamic = False, Default = \"32", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kSquareBracket, Type = Double, Dynamic = False, Default = \"91", Scope = Private
	#tag EndConstant

	#tag Constant, Name = kTab, Type = Double, Dynamic = False, Default = \"9", Scope = Private
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
