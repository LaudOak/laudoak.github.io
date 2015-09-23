---
layout: post
categories: Android
title: "BaseAdapter & ViewHolder"
---

###A Typical Viewholder

####in Adapter calss
```Java
@Override
    View callView(int position, View convertView, ViewGroup parent) {

        ViewHolder holder;

        if(null==convertView)
        {
            convertView = mInflater.inflate(R.layout.view_item_repairer_task,parent,false);
            holder = new ViewHolder(convertView);
        }else {
            holder = (ViewHolder) convertView.getTag();
        }

        if(null!=holder)
        {
            holder.bindData(mDataList.get(position));
        }

        return convertView;
    }
```

####in ViewHolder class
```Java

class ViewHolder
    {
        TextView describe;
        TextView site;
        TextView type;
        TimeTextView submitTime;
        TriangleView state;

        public ViewHolder (View view)
        {
            describe = (TextView) view.findViewById(R.id.item_repairer_task_describe);
            site = (TextView) view.findViewById(R.id.item_repairer_task_site);
            type = (TextView) view.findViewById(R.id.item_repairer_task_type);
            submitTime = (TimeTextView) view.findViewById(R.id.item_repairer_task_submittime);
            state = (TriangleView) view.findViewById(R.id.item_repairer_task_state);

            view.setTag(this);
        }

        void bindData(Crash crash)
        {
            describe.setText(crash.getmDescribe());
            site.setText(crash.getmSite());
            type.setText(crash.getmType());
            submitTime.setmPublishTime(TimeUtils.parseDateStringToLong(crash.getmSubmitTime()));

            switch (crash.getmState())
            {
                case 0:
                {
                    state.setStatus(0);
                    break;
                }
                case 1:
                {
                    state.setStatus(1);
                    break;
                }
                case 2:
                {
                    state.setStatus(2);
                    break;
                }
            }
        }
    }

```