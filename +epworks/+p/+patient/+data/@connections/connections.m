classdef connections
    %
    %   Class:
    %   epworks.p.patient.data.connections

    properties
        s

        client
        sink
        source
    end

    methods
        function obj = connections(s,r)
            obj.s = s;
            n_children = length(s.child_indices);
            for i = 1:n_children
                index = s.child_indices(i);
                r.processed(index) = true;
                s2 = r.getStruct(index);

                switch s2.name
                    %{
                    case 'AudioVolume'
                        obj.audio_volume = double(typecast(s2.raw_data,'uint32'));
                    case 'Color'
                        obj.color = double(s2.raw_data);
                    case 'HffCutoff'
                        obj.hff_cutoff = typecast(s2.raw_data,'double');
                    case 'IsAlarmedWave'
                        obj.is_alarmed_wave = double(typecast(s2.raw_data,'uint32'));
                    %}

                    case 'Client'
                        obj.client = epworks.p.patient.data.connections.client(s2,r);
                    case 'Sink'
                    case 'Source'

                    otherwise
                        keyboard
                end
            end
            
        end
    end
end