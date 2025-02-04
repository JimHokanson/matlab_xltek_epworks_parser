classdef waveform < epworks.p.parse_object
    %
    %   Class:
    %   epworks.p.rec.waveform
    %
    %   See Also
    %   --------
    %   epworks.parse.rec_parser

    properties
        timestamp
        id
        data
        d2
    end

    methods
        function obj = waveform(i,data,default_length,trace,ochan)
            %

            bytes = data';

            %1:4 - # of bytes to read at a time
            %5:20 - id
            %21:28 - timestamp
            %29:41 - empty
            %42 - value of 64 - is this a # of columns/rows thing?
            %45 - starts counting up, 1 through n
            %       - why start counting before a meaningful number
            %        at byte 46?
            %46:48 - value of [202 154 59]
            %
            %   45:48 => 1E9+1
            %
            %   old code did the following words:
            %29:32 - uint32
            %33:36 - uint32
            %37:40 - uint32
            %41:44 - uint8
            %45:48 - uint32
            %49:52 - uint32
            %43:56 - uint32
            %57:60 - single, stim amp
            %
            %   first of anythign in this sample is 889
            %   - is this because there are just 0s for some amount
            %   of data?

            n_bytes_read = double(typecast(bytes(1:4),'int32'));
            if n_bytes_read ~= default_length
                error('Assumption violated')
            end
            obj.id = bytes(5:20);
            obj.timestamp = epworks.utils.processType3time(bytes(21:28));

            % if i > 40 && contains(string(trace.name),'F3')
            %     keyboard
            % end

            %892 - first non-zero sample
            obj.data = double(typecast(bytes(889:end),'single'));
            obj.d2 = double(typecast(bytes(89:end),'single'));
            %obj.data = data(89:end);

            %{
                d1 = data(121:end);
                d2 = data(889:end);
                    %10 - yes

            12:57:44 to 13:18:23 - 1109 seconds
            ~19.46 seconds
    
            4 seconds, 2400

            %2400 samples
            d2 = double(typecast(bytes(889:end),'single'));


            d3 = double(typecast(bytes(89:end),'double'));
            d4 = double(typecast(bytes(89:end),'int16'));
            d5 = bytes(889:end);
            %}
        end
    end
end